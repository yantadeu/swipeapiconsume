import React from 'react';
import Swipe from '@swp/swipe-sdk';
import axios from 'axios';

export default class NewAccount extends React.Component {
    state = {loading: false, results: []};
    swp = [];

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
    };

    componentWillMount() {

    }

    render() {
        const {loading, results} = this.state;
        return (
            <div className="ui raised segment no padding">

            </div>
        );
    }
}