Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD870
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 08:51:04 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id di13so9320807edb.2
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:cc:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AIiJ+NlLszHEaCHwEywkn2RBU63Z1sbxb05mzltEDkc=;
        b=lQ+VtY9uUjlK3JOmVRgMbG1FGjvxqQH2Cw9x7/hbu7YTI/rG2HUxa8liIztX8/fe4b
         xbVNJiQEq304kf+El5yku9d8n9dpkFfTPBlLfshheup2VGHoe0JdqQkk3rEDo9tOS4AR
         VDH4WWk2szCNMZgaUhrGNJL9iAbj94sKj8ioCEKBz/udl+cuxGB4Qp8WJhzLisORT4pm
         Gg073zN1buM/IDkVfuVADr/60BeQhtaDBBYbYLdLdlZWjurmIsvbMs6eTVHg2tI7+rJ1
         pp86oiqhXIY2f/zxa28Gp9vZ2v4NNp0GC1p/myWP++YJ6ZRaDuK8OekhWrK4phDkTQuO
         XQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIiJ+NlLszHEaCHwEywkn2RBU63Z1sbxb05mzltEDkc=;
        b=jXM3rsUPELuVU/6/Vhm615ltrv3ThoM487Epgm/fP36N//QaQMd4rpz83fFLqmXCuj
         DzlIcoOCOFSmcrzo/7+zxvsRhgAToUfyhk3IBcOHS2R+pRloztzF5317YoXQ8dpwUQM0
         queHPtdnpANwHFzNEygDu8CHeZnE6uH/CXRCWo6TplbhwqxokbxVRkCE8+lT2XNWkTSR
         OvWNgEYossaH+C5bhr6+UYDgBWtEGH5QgC1ODLakReSP/mnr6FVzQNA1dj/N3A3uF+xu
         DlA7H5aex1REsvM7u3+HhoufrUvXgdXC8xtfRG7ZKO979QkoBLn/1YFDleThAVfSztC8
         WYmg==
X-Gm-Message-State: AOAM53184pZAeTZTbqgMSg8+eyl4W5y73d8lfnII00REZdp1dlYzUpa1
	tlx/FGlenvZzv49YDQ4gfi4TwuyqeD5y7lEb+C8Pqw==
X-Google-Smtp-Source: ABdhPJxajce2NJLdNT6qsG5VCuHV+60vP6JJ+UKHFzYPCnGrsHm0DEy2y5dgSpjJNHIyqzLjS1Rwcw==
X-Received: by 2002:a05:6402:683:: with SMTP id f3mr9794769edy.22.1620377462729;
        Fri, 07 May 2021 01:51:02 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2fa9:2d27:234d:525d])
        by smtp.gmail.com with ESMTPSA id bu20sm3051360ejb.76.2021.05.07.01.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 01:51:02 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>
References: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: don't fallback when data_fin
 enabled
Message-ID: <c92941a2-d629-ae34-23e3-18faec2a3750@tessares.net>
Date: Fri, 7 May 2021 10:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/05/2021 09:58, Geliang Tang wrote:
> This patch fixed this fallback error:

Thank you for the patch!

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f3e379a0f08d..940b32511443 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -901,7 +901,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  	 * MP_JOIN subflows.
>  	 */
>  	if (!mp_opt->mp_capable) {
> -		if (subflow->mp_join)
> +		if (subflow->mp_join || mptcp_data_fin_enabled(msk))>  			goto reset;

I don't think we should send a reset here. For me this behaviour is normal.

When looking at the debug trace:

> <7>[ 1485.133416] MPTCP: msk=00000000875940e7, token=2833190200 side=0
> <7>[ 1485.134972] MPTCP: msk=00000000875940e7 snd_data_fin_enable=0
shutdown=3 state=4 pending=0

It looks like the userspace has closed the connection:

  mptcp_close() → __mptcp_wr_shutdown()

There we do:

  /* will be ignored by fallback sockets */
  WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
  WRITE_ONCE(msk->snd_data_fin_enable, 1);

> <7>[ 1485.134987] MPTCP: msk=00000000875940e7 snd_data_fin_enable=1
pending=0 snd_nxt=13562085501921405457

From:

  __mptcp_check_send_data_fin(sk);

> <7>[ 1485.135233] MPTCP: msk=00000000875940e7 state=4

From:

  mptcp_close()

> <7>[ 1485.135472] MPTCP: check_fully_established:fallback to TCP
(msk=00000000875940e7)

It means we certainly got a FIN back:

  mptcp_incoming_options() → check_fully_established()

> <7>[ 1485.339305] MPTCP: msk=00000000875940e7 snd_data_fin_enable=1
pending=0 snd_nxt=13562085501921405458 write_seq=13562085501921405458

From:

  __mptcp_check_send_data_fin()

But here we will not send the DATA_FIN because we did a fallback to TCP.
But we change the state to properly close the socket.

> <7>[ 1485.339329] MPTCP: msk=00000000875940e7

By chance, do you have a packet trace to confirm that?

It's unclear to me if we send a DATA_FIN in this case. I guess we should
not if we are not in fully_established and I think that's what we do but
I'm unsure now.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
