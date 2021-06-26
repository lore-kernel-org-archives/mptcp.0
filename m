Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8E2FB2
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=YFT1v
	iJ4tjK9f4wo1lQRP91dE5USVky459zb8l1s0J4=; b=ghkk54iOccDJrmAFowwIX
	M6/85SFKDPAUCsuMdiKKsfOHESvav9FXTWDiGzAhSh5YSrf2GzIldyvq5ha1Lz0D
	SPmQVSoG+A4o+XllwN7c90SUDvW+JYsrguZ+ReWuMfcRmJiFAG6KgpuqtHkPX2bk
	MTVY+KrQA0lavrMJCjxAig=
Received: from [10.8.0.74] (unknown [36.111.140.26])
	by smtp9 (Coremail) with SMTP id DcCowADnF_F47NZghdv7IA--.39526S2;
	Sat, 26 Jun 2021 16:59:38 +0800 (CST)
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
 <1624609559-6786-5-git-send-email-wujianguo106@163.com>
 <9d8a2d8ae7930e741f5441a36ef19d8039731a02.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <1352450a-c975-0031-b57a-527bbb928fdf@163.com>
Date: Sat, 26 Jun 2021 16:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9d8a2d8ae7930e741f5441a36ef19d8039731a02.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DcCowADnF_F47NZghdv7IA--.39526S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DCF13XFy7ZF4xGw43GFg_yoW8Xr4xpF
	1kta4UCrs5uFyfuw40yF4kuryF9a1YyrW3Ga15G3W5AFsxGFn3KFy5Kay5trW3AFWIka47
	AayvvFn8ur43AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBQ6JUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxq9kF5u+2+jDgAAsZ

Hi Paolo,

On 2021/6/25 18:45, Paolo Abeni wrote:
> Hi,
> 
> I'm sorry for the partial feedback in my previous reply.
> 
> On Fri, 2021-06-25 at 16:25 +0800, wujianguo106@163.com wrote:
>> @@ -856,7 +856,8 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>>  static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>  				    struct mptcp_subflow_context *subflow,
>>  				    struct sk_buff *skb,
>> -				    struct mptcp_options_received *mp_opt)
>> +				    struct mptcp_options_received *mp_opt,
>> +				    bool *subflow_is_rst)
> 
> This additional argument is not needed...
> 
> [...]
>> @@ -1053,12 +1057,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>  			__mptcp_check_push(subflow->conn, sk);
>>  		__mptcp_data_acked(subflow->conn);
>>  		mptcp_data_unlock(subflow->conn);
>> -		return;
>> +		return 1;
>>  	}
>>  
>>  	mptcp_get_options(sk, skb, &mp_opt);
>> -	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>> -		return;
>> +	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt, &subflow_is_rst))
>> +		return subflow_is_rst ? 0 : 1;
> 
> 
> ... here you can simply:
> 
> 		return sk->sk_state != TCP_CLOSE;
> 
> plus some comment above alike:
> 
> """the subflow can be in close state only if check_fully_established()
> just sent a reset. If so, tell the caller to ignore the current
> packet"""
> 

Thank you for all your reviews and suggestions！New version coming soon.

> /P
> 

