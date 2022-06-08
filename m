Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0C320A
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654707079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCqb9YNQjGN60a86+s4t1G7mBqjgh9f+HNWPdfPmI7c=;
	b=Qt3d5ak9YVH049brkP1HZh4z8oZs/TQcohOS9a6Xk3OWwaka//xxnb0UmhMraiSAixRQW5
	H8Dvk2Ejg4nDyWDm3EYJp4jXhIBe9OUdv14EF2prwxFjlxbeDyKonuuqHUKnom7hb9zShX
	yeQHlxaQ/nqlvNFsZqL5ai+9q+Klvs4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-FeAHyqkMOxGpAgFbA6vNoA-1; Wed, 08 Jun 2022 12:51:18 -0400
X-MC-Unique: FeAHyqkMOxGpAgFbA6vNoA-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso13281871qvb.15
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NCqb9YNQjGN60a86+s4t1G7mBqjgh9f+HNWPdfPmI7c=;
        b=aAS+qgtC8+PKmOhqzEaHg1gqmhG+vpYxGTPCyNecQEBlhbsHV20rO+Gpw1sZIttKjI
         bGHTnDs3Z8W2CJ8WAN8N7zXf2VjDpROFrWKZQsmhL+HCRJXEXE32Ajw93qNyIlgc/lW5
         gReHaq5QPndhGqIUn8b3OQJEsUVAnZbwhRox7dunIltnbRsyNtWvvEMV6bS+KXIBDChO
         vL4o2al2SGAxsPxkHwo01jm3+adMCZvnk/8p4T+HFepbFeOMeqxymnDZdfVefHKHG2bq
         X5l4TE3ZPyw8bGOEop9aFrIFRQay4J3ruv9zq7PfekrruOfyUoPcOZwk0uneLgsEEj0t
         WBhQ==
X-Gm-Message-State: AOAM5331ecPWQAbjLhcyYAS+4FJf4oWnocnkmEAKQ/3LPqXBJsOn2G4R
	mpTkIIQfuu/W/qB0bqBC/ae4B4WvFQw47O6ggsS92N67vygmMBymFF6efYJFjivNK/HVML5n37l
	YtZLOt6jPdKkRWEQ=
X-Received: by 2002:a05:620a:12b9:b0:6a7:1832:bdd4 with SMTP id x25-20020a05620a12b900b006a71832bdd4mr1392425qki.193.1654707078091;
        Wed, 08 Jun 2022 09:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6NE6rkBF516XMCLFrtxdEzs0qNV47u53jAD12LlORsXiH6JGxnbOWNmZuiVts08ZsLg1Ag==
X-Received: by 2002:a05:620a:12b9:b0:6a7:1832:bdd4 with SMTP id x25-20020a05620a12b900b006a71832bdd4mr1392416qki.193.1654707077803;
        Wed, 08 Jun 2022 09:51:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id x19-20020ac85f13000000b002f9ba2b666csm15159099qta.58.2022.06.08.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:17 -0700 (PDT)
Message-ID: <ed3e810dacb60c72ad1cf9ab73284a7623d12ba6.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3] mptcp: refactor MP_FAIL response
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 08 Jun 2022 18:51:14 +0200
In-Reply-To: <527414fccf0c041908900aadb2f043134a0ec09c.1654694739.git.geliang.tang@suse.com>
References: <527414fccf0c041908900aadb2f043134a0ec09c.1654694739.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-06-08 at 21:26 +0800, Geliang Tang wrote:
> This patch refactors the MP_FAIL response logic.
> 
> Add fail_sock in struct mptcp_sock to record the MP_FAIL subflow. Add
> fail_timeout in mptcp_sock to record the MP_FAIL timestamp. Check them
> in mptcp_mp_fail_no_response() to reset the subflow when MP_FAIL response
> timeout occurs.
> 
> Drop mp_fail_response_expect flag in struct mptcp_subflow_context and
> the code to reuse sk_timer.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/281
> Fixes: d9fb797046c5 ("mptcp: Do not traverse the subflow connection list without lock")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  v3:
>  - update as Paolo suggested.
> ---
>  net/mptcp/pm.c       |  7 ++-----
>  net/mptcp/protocol.c | 26 ++++++--------------------
>  net/mptcp/protocol.h |  3 ++-
>  net/mptcp/subflow.c  | 12 +++---------
>  4 files changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 59a85220edc9..c780e5d11b89 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -299,23 +299,20 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> -	struct sock *s = (struct sock *)msk;
>  
>  	pr_debug("fail_seq=%llu", fail_seq);
>  
>  	if (!READ_ONCE(msk->allow_infinite_fallback))
>  		return;
>  
> -	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
> +	if (!msk->fail_sock) {
>  		pr_debug("send MP_FAIL response and infinite map");
>  
>  		subflow->send_mp_fail = 1;
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
>  		subflow->send_infinite_map = 1;
> -	} else if (!sock_flag(sk, SOCK_DEAD)) {
> +	} else {
>  		pr_debug("MP_FAIL response received");
> -
> -		sk_stop_timer(s, &s->sk_timer);
>  	}
>  }
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d6aef4b13b8a..9ffc96ddce01 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2167,21 +2167,6 @@ static void mptcp_retransmit_timer(struct timer_list *t)
>  	sock_put(sk);
>  }
>  
> -static struct mptcp_subflow_context *
> -mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> -{
> -	struct mptcp_subflow_context *subflow, *ret = NULL;
> -
> -	mptcp_for_each_subflow(msk, subflow) {
> -		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> -			ret = subflow;
> -			break;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
>  static void mptcp_timeout_timer(struct timer_list *t)
>  {
>  	struct sock *sk = from_timer(sk, t, sk_timer);
> @@ -2507,18 +2492,17 @@ static void __mptcp_retrans(struct sock *sk)
>  
>  static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
>  {
> -	struct mptcp_subflow_context *subflow;
> -	struct sock *ssk;
> +	struct sock *ssk = msk->fail_sock;
>  	bool slow;
>  
> -	subflow = mp_fail_response_expect_subflow(msk);
> -	if (subflow) {
> +	if (ssk && time_after(jiffies, msk->fail_timeout)) {

The patch LGTM, thanks! 

Acked-by: Paolo Abeni <pabeni@redhat.com>

As minor nits I *think* that 'fail_sock' could be renamed to
'fail_ssk', for consistency (a 'sock' is usally a 'struct socket') and
I *think* that the above msk->fail_sock/msk->fail_ssk check could be
moved into mptcp_worker() function to make it clear that the
fail_no_response thing is not unconditional.

As said, minor things, could be handled with a squash-to patch, if
there is agreement on them.

Cheers,

Paolo

