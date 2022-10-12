Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481B17ED
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 15:39:25 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id bj12so38742061ejb.13
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5Isg4TeVNBYLecWxZ+OTpavjBe1AuMQUPQvMOnEOTk=;
        b=ml1w+AaBz2nAONxSVcZZExr4aSFDw1dFmfkNjU7rn89vIL4hNA44lnKBTOHDaFNLs3
         3PWMixV2/MjeHHg3oU9yta4wHhef0v9NdkcuB9SYDhjxsNv+RoR83OYzL/5pMINFlrla
         mTwmkHhTq8yRwsf8EC3LFWfFmIMkPB8gDzYkmrfhXkmEB9+Ihu8e5+l4xopWmxf9LSif
         TeeDNt43+6OTA7QKHggJG9xJX0aGJHr4TWR9BIfA8tjKkJl/CX3OR6JvzB5p9mH6ogPG
         dLagt+WUz6SSx8wLqgN8XsxCZSwfXf6zKO98jiWzn3xTyxI0BkfClejOSlsG4RXviQ0c
         1qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5Isg4TeVNBYLecWxZ+OTpavjBe1AuMQUPQvMOnEOTk=;
        b=x0YEeFbwlLSlvr4kQxdz3PzXBdav7Cu3EuuDxbAzG2YpOsNA8FewA5pNH2EdiidTuc
         Cvjut+U4BRSQgV2Mu1+baht6FSP6nFpYtVV7c6wk3n4HbJCw8VbNUv5BSYBaA/34IAT/
         sXx1g4ABS2JKFK5WDssZfGDHtiB8O+FHhfoV4oqjmcZKc7pKTBUuemBd8+O8szGKnvzI
         vmdwe5vll1kG/8qYOx0EaGyIr39zl1HlwFTX4yw/neMRNfevxzPpZxWRpzVERTCpG0sZ
         jDq8Te5RwWmYQ+ogk1G81QCjjHH4JAxzCIouR1NwnSujchIMxUv4pl/CvwGHCKwmzykV
         jKCQ==
X-Gm-Message-State: ACrzQf21Fh6DAY78i0nn/5rJkC/xNZJxkOJ41VyJojJRU4NSwsW0P0/b
	QnlyOIzvjOCP3oeTUFJgtK/wM1a8tPcJFA==
X-Google-Smtp-Source: AMsMyM7ptgZs9txitPyA1N5hLdHgozQYscmWDdiRt/9rta/arcyGot2XQ9o/XdbWOf9vkrI9jhlubQ==
X-Received: by 2002:a17:907:a06d:b0:78d:ceae:ba5a with SMTP id ia13-20020a170907a06d00b0078dceaeba5amr8893754ejc.586.1665589163221;
        Wed, 12 Oct 2022 08:39:23 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a070:1697:e229:d255? ([2a02:578:8593:1200:a070:1697:e229:d255])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090632da00b0078d4962a46bsm1418048ejk.190.2022.10.12.08.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:39:22 -0700 (PDT)
Message-ID: <dee06f30-f5ea-deb3-9d40-b4f7a5d460df@tessares.net>
Date: Wed, 12 Oct 2022 17:39:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net v3] mptcp: fix abba deadlock on fastopen
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 12/10/2022 16:48, Paolo Abeni wrote:
> Our CI reported lockdep splat in the fastopen code:

(...)

> The problem is caused by the blocking inet_wait_for_connect() releasing
> and re-acquiring the msk socket lock while the subflow socket lock is
> still held and the MPTCP socket requires that the msk socket lock must
> be acquired before the subflow socket lock.
> 
> Address the issue always invoking tcp_sendmsg_fastopen() in an
> unblocking manner, and later eventually complete the blocking
> __inet_stream_connect() as needed.

Thank you for the v3!

I just have one last question here below (+ 2 small comments but a v4 is
probably not needed):

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1cdf9cd1a3cc..82d899233df4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
>  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
>  }
>  
> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
> +				  size_t len, int *copied_syn)
> +{
> +	unsigned int saved_flags = msg->msg_flags;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int ret;
> +
> +	lock_sock(ssk);
> +	msg->msg_flags |= MSG_DONTWAIT;
> +	msk->connect_flags = O_NONBLOCK;

Just to be sure I understand properly: here O_NONBLOCK is set but that
will only be used for the subflow and only if MSG_FASTOPEN is set (and
allowed), so not for TCP_FASTOPEN_CONNECT, right?

But no need to reset them later, right?

(I'm a bit confused by the fact we set msk->connect_flags in
mptcp_stream_connect() before calling __inet_stream_connect() and not
here below)

> +	msk->is_sendmsg = 1;
> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> +	msk->is_sendmsg = 0;
> +	msg->msg_flags = saved_flags;
> +	release_sock(ssk);
> +
> +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
> +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
> +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
> +					    msg->msg_namelen, msg->msg_flags, 1);
> +
> +		/* Keep the same behaviout of plain TCP: zero the copied bytes in

s/behaviout/behaviour/ but I can fix that when applying the patch, I
guess "checkpatch.pl --codespell" will remind me that.

> +		 * case of any error, except timeout or signal
> +		 */
> +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
> +			*copied_syn = 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	ssock = __mptcp_nmpc_socket(msk);
>  	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> -		struct sock *ssk = ssock->sk;
>  		int copied_syn = 0;
>  
> -		lock_sock(ssk);
> -
> -		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> -		msk->is_sendmsg = 1;
> -		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
> -		msk->is_sendmsg = 0;
> +		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);


It might look a bit strange to add some code here and then move it to a
dedicated function in the following commit but I'm sure that will be
fine for other net maintainers! :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
