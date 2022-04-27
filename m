Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062F7B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651049823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwdI6CDoIkIt3vjgbkXzuvqrFMDsRWAD27/akgHrbRM=;
	b=a2k/V42X6c64LoNc9sCI3xM7v3ycUF8cpTae/m2UphC+4ODgAIRPjvHS44A6vNCLqPAEG5
	No4rOuT5MkNXgMCJIAQ4sr/mYPfwJHUhFHjg/3iT+8P/sqbrihv1tDeq1cHxhDIHIxSkxl
	Up89w8i2D95pqVwzafgsw5K6HlWZLyI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-kNj-UtfSNDu0I7u3y_t90Q-1; Wed, 27 Apr 2022 04:57:02 -0400
X-MC-Unique: kNj-UtfSNDu0I7u3y_t90Q-1
Received: by mail-qt1-f198.google.com with SMTP id l11-20020a05622a174b00b002f37e3fe6easo677502qtk.18
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GwdI6CDoIkIt3vjgbkXzuvqrFMDsRWAD27/akgHrbRM=;
        b=I2PZAKoC4zJe499jnuDJOqQeLlLN7m/KtXZtqzOho+MJcoR5myI5Sps5dPiozZLXTM
         xfCpsBxLVNr9dSAg4jTYG6uFfwf6R0FWmERQ0Pck/O6otn02h06eHAnmA9r6QwVgZ0P9
         wmuugSQ43tBGG8TgGhvFFcOzzatNaGtqDlx/bEUhSu5EFT55ylbdtGxqR2knYK8YoWp4
         HO/3sNP9z/xWHy5kOw3T7c1UUDwCLfm/bwPuyUvQINruZrFesg3gCgYVHa0Y5/uYWJSb
         EjQWYN2DX6SNkxdNPtdoGPU8M4JJzEhlZZZrTdPQGOVucWC2E8cay4pRgnS35ybpep/M
         dHhw==
X-Gm-Message-State: AOAM532PgDO6pYlXRMBD+th1LfNTJx8WqXu1+/Tx/UcW4h+PgP4iFNqR
	5xwbhlSDDwE1ITg4u1Z6YaP+sNDRxHrbYDFKFMeyXhHd+Qm2m6yTSErc+OyxUFhy3BoSjNhiZ1w
	6mocefjVkA3ShQT8=
X-Received: by 2002:ac8:6ce:0:b0:2f0:29dd:bbc5 with SMTP id j14-20020ac806ce000000b002f029ddbbc5mr18603869qth.216.1651049821799;
        Wed, 27 Apr 2022 01:57:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhLon3J1mpSY366o6oWaXw2OMzHjxNoI+rL1ujXaSlHPjJGCYDqC6Bb/oeqbWra15X9kU+kA==
X-Received: by 2002:ac8:6ce:0:b0:2f0:29dd:bbc5 with SMTP id j14-20020ac806ce000000b002f029ddbbc5mr18603859qth.216.1651049821509;
        Wed, 27 Apr 2022 01:57:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-117-160.dyn.eolo.it. [146.241.117.160])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm9347107qtj.28.2022.04.27.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:57:01 -0700 (PDT)
Message-ID: <f44dc02fdc2041cda773d6cb2a848a7b4f625dab.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v16 5/8] mptcp: add get_subflow wrapper
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 27 Apr 2022 10:56:57 +0200
In-Reply-To: <d0234513a342a1c3e833c73663feac656d935cfc.camel@redhat.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
	 <f69a828ffffa6b0a57d8913a273d84a9150cc860.1651024344.git.geliang.tang@suse.com>
	 <d0234513a342a1c3e833c73663feac656d935cfc.camel@redhat.com>
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

On Wed, 2022-04-27 at 10:27 +0200, Paolo Abeni wrote:
> > +
> > +	msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
> > +					  mptcp_get_subflow_default,
> > +					  msk, reinject, &data) :
> > +		     mptcp_get_subflow_default(msk, reinject, &data);
> 
> With this we have quite a lot of conditionals for the default
> scheduler. I think we can drop the INDIRECT_CALL_INET_1() wrapper, and
> rework the code so that msk->sched is always NULL with the default
> scheduler.

Even better, we could drop the mptcp_get_subflow_default() wrapper and
call directly the current scheduler when msk->sched is NULL, even
before filling the 'data' struct. That should fit nicely expecially if
we use 2 separate ops for plain xmit and retrans.

Overall that would lead to something alike:

---
static inline struct sock *mptcp_sched_get_send(struct mptcp_sock msk)
{
	struct mptcp_sched_data data;

        sock_owned_by_me(sk);

	/* the following check is moved out of mptcp_subflow_get_send */
        if (__mptcp_check_fallback(msk)) {
                if (!msk->first)
                        return NULL;
                return sk_stream_memory_free(msk->first) ? msk->first : NULL;
        }

	if (!msk->sched)
		return mptcp_subflow_get_send(msk);

	data.sock = msk->first; /* if needed */
	data.call_again = 0;	/* if needed */
	msk->sched->get_send(msk, &data);
	msk->last_snd = data.sock;
	return data.sock;
}
---
plus something similar for retrans.

Thanks!

Paolo

