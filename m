Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B71852
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651248471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8f2KTDzfZJBZkXRqqytS+UczhyhELTFmaLqTT/44hUk=;
	b=bQEUXIW97XoC5UOjJz6DFdpYKpWUZCPb48XlJ0iE9IC4nQjXaocc3MCZYsKvcmUBO9/4TL
	/HCcqH0N60mN/ksCItlTLo0e7sDpYeEviRIwUKM8ACUFLxcMRO0kQ5QuFwPMiq9uPsZ6vI
	HXhapFVdC8HZ0rurNV4JTSisAVlwHjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-WZeSodryOuqYnnFucC2etw-1; Fri, 29 Apr 2022 12:07:49 -0400
X-MC-Unique: WZeSodryOuqYnnFucC2etw-1
Received: by mail-wr1-f72.google.com with SMTP id t17-20020adfa2d1000000b0020ac519c222so3207105wra.4
        for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 09:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8f2KTDzfZJBZkXRqqytS+UczhyhELTFmaLqTT/44hUk=;
        b=amY/quysLf5F24lN1AeHJomupsWkey/+WLZi8VTubrzUJhWDt0n3CTWtFgi6mqR7oK
         TbpWda3dxN+UA/b/3tJFde7TqCik9hIXM7G6fWtKaKETzsiIueBmb8m0oAlN+A0E3r81
         8lXYi4f/YlgtcNc3HkxKTrhhyUxv6/7zGnuIZ94j2odMPXBojZtdq1+hc8YNCEtU4vTH
         bP5TPL3GGoUIFmFEbcKIpjOJUAGiJ9n2FFerTLfO5Xs9uOum+hfulNf9iDyVX3iZx/TP
         LI7Gv22j9fQW5JpmjhX6+uy/Unm+EJWrPq/o723WoItCjRcKEwBZ8JR3O9TvNUL+qP4t
         nSWQ==
X-Gm-Message-State: AOAM533pRqT5Ckg+wX3Uqu2TkHN/IsbYCqprAQpwMVKN5sm3SWwdt+f5
	b/x3CBHFuorp3fr7ehZu2SdD7bZiFaCn8hpBIhStLG2tWhxbZeUz1XcMXWL6XaCXkHYyhsZQsaA
	QKK/dUpdga5OizyGfnqsPErJ2TEk8/9Hmjr16rSEMBBYo1eVqjqxqCKm7yhya/Jf5
X-Received: by 2002:a05:600c:2198:b0:394:1397:db36 with SMTP id e24-20020a05600c219800b003941397db36mr3957846wme.90.1651248468167;
        Fri, 29 Apr 2022 09:07:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrhA82BM4lETeo7SOhCh989eq9X+NBczVLicDUbcDwqlzjTBVel8oabKK/7ohdsPMou1qyig==
X-Received: by 2002:a05:600c:2198:b0:394:1397:db36 with SMTP id e24-20020a05600c219800b003941397db36mr3957820wme.90.1651248467816;
        Fri, 29 Apr 2022 09:07:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-105.dyn.eolo.it. [146.241.96.105])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b0020aea5d4085sm3346923wri.20.2022.04.29.09.07.47
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:07:47 -0700 (PDT)
Message-ID: <fd37ce1a779cd13005dd40c13e28c9a20c034de9.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] net/sched: act_pedit: really ensure the skb
 is writable
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 29 Apr 2022 18:07:46 +0200
In-Reply-To: <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
References: <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
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

On Fri, 2022-04-29 at 17:52 +0200, Paolo Abeni wrote:
> Currently pedit tries to ensure that the accessed skb offset
> is writeble via skb_unclone(). The action potentially allows
> touching any skb bytes, so it may end-up modifying shared data.
> 
> The above causes some sporadic MPTCP self-test failures.
> 
> Address the issue keeping track of the (estimated) highest skb
> offset accessed by the action and ensure such offset is really
> writable.
> 
> Note that this may cause performance regressions in some scenario,
> but hopefully pedit is not critical path.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this almost solves issues/265 here. I'm still getting some rare
> failure with MPTcpExtMPFailTx==0: sometimes the transfer completes
> before we are able to use the 2nd/failing link. The relevant fix
> is a purely seft-test one
> ---
>  include/net/tc_act/tc_pedit.h |  1 +
>  net/sched/act_pedit.c         | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
> index 748cf87a4d7e..3e02709a1df6 100644
> --- a/include/net/tc_act/tc_pedit.h
> +++ b/include/net/tc_act/tc_pedit.h
> @@ -14,6 +14,7 @@ struct tcf_pedit {
>  	struct tc_action	common;
>  	unsigned char		tcfp_nkeys;
>  	unsigned char		tcfp_flags;
> +	u32			tcfp_off_max_hint;
>  	struct tc_pedit_key	*tcfp_keys;
>  	struct tcf_pedit_key_ex	*tcfp_keys_ex;
>  };
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index e01ef7f109f4..5ff37da2f9c3 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -149,7 +149,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
>  	struct nlattr *pattr;
>  	struct tcf_pedit *p;
>  	int ret = 0, err;
> -	int ksize;
> +	int i, ksize;
>  	u32 index;
>  
>  	if (!nla) {
> @@ -228,6 +228,16 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
>  		p->tcfp_nkeys = parm->nkeys;
>  	}
>  	memcpy(p->tcfp_keys, parm->keys, ksize);
> +	p->tcfp_off_max_hint = 0;
> +	for (i = 0; i < p->tcfp_nkeys; ++i) {
> +		u32 cur;
> +
> +		/* AT reads a single byte, we can bound the offset with UCHAR_MAX,
> +		 * each key will touch 4 bytes
> +		 */
> +		cur = p->tcfp_keys[i].off + p->tcfp_keys[i].offmask ? UCHAR_MAX >> p->tcfp_keys[i].shift: 0;

I'm dumb: I did some cosmetic editing before submitting this one
without re-testing, and they broke the build. I'll send a v2.

/P

