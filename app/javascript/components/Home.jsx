import React from 'react';
import axios from 'axios';

import SearchResultList from './SearchResultList';

export default class Home extends React.Component {
    state = {loading: false, results: []};
    swp = {};

    onChange = (e) => {
        const {value} = e.target;
        this.setState({loading: true});
        if (value.length > 0) {
            axios.get('/search.json', {params: {query: value}})
                .then(res => this.setState({loading: false, results: res.data}))
                .catch(() => this.setState({loading: false, results: []}));
        } else {
            this.setState({loading: false, results: []});
        }
    }

    componentWillMount() {
        // this.swp = Swipe.init({
        //     apiKey: "13c59e68dfaf2838e5fc444a6187fd1d06b0f2d28b3c9195c5fc46d2d18ccbb1",
        //     secret: "140af905a8a9e073f40dbd3991f7ecc371c2513b20561b03a4adf42f75f58c62",
        //     sandbox: true,
        //     language: Wallet.languages.PT_BR
        // });

    }

    render() {
        const {loading, results} = this.state;
        return (
            <div className="ui raised segment no padding">
                {/*<form method="GET" action="search">*/}
                    {/*<div className="ui fluid icon transparent large input">*/}
                        {/*<input name="query" type="text" placeholder="Pesquisar Organizações" onChange={this.onChange}*/}
                               {/*autoComplete="off"/>*/}
                        {/*<button type="submit">*/}
                            {/*<i className="search icon"></i>*/}
                        {/*</button>*/}
                    {/*</div>*/}
                    {/*{results.length > 0 || loading ? <SearchResultList results={results} loading={loading}/> : null}*/}
                {/*</form>*/}
            </div>
        );
    }
}