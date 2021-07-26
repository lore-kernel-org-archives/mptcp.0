Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74963168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627297846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ac3y4cPs88FgIXAOvqKudmWInWW98J70+thA+eMydSc=;
	b=GO8fy5ZMW3TDoZMlE1u57q9c/hjt1yjn4K5l6nof/WuNykgIaVBw0UIwErtJKnbBJgvaGL
	3k98d/lhtcOtz03EOxwx8Cj6XTIKrN5okbrUmnI30ZhFfvLgnIZ6TmdhUE9hKVR8m/EXeJ
	E7gOlS14sYe85pLzJASxS4SanLTYz/0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-GYmUFUzsMuKkRKm8NU44Yg-1; Mon, 26 Jul 2021 07:10:45 -0400
X-MC-Unique: GYmUFUzsMuKkRKm8NU44Yg-1
Received: by mail-wm1-f71.google.com with SMTP id a1-20020a7bc1c10000b0290225338d8f53so3028095wmj.8
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ac3y4cPs88FgIXAOvqKudmWInWW98J70+thA+eMydSc=;
        b=pdlfPCB17JccX/QRCOJ2xaBvM/iyJUAOI7a5g65qPPKlQLBykoU3LGEQT6Dg1uwXf9
         KC+hmUf+Yie1znRvl3bl9Ncfg+CjKfpL4gwbQCMXuWdI2O9ZXJuXoJSxgzgD+BycyQqQ
         0LzQCFeIugt7lioqwCZOY0e7RwTwOgVQxG7FVTS63I42/o6uIjHI2Zg16XrQSxWGUsUa
         Zr70LO9dbduY6E8psC7q7G3y3Ekf5m0Ec2MLnU/64dT3S/+lJ8PQ4WIFCGB884BbdDUA
         VvYTrJdsnqlB4RQZc9LVBL2pG1OQgl3GI67kFJ9ejfwzxlJCM/hAxvjGQ7q65gnwF/oZ
         i47Q==
X-Gm-Message-State: AOAM531+zUNfhW2NVEE9TDRUADbQyTltye08JKbV0Ud8Ip99Bb4PQeD/
	pKgTchzPLFVZk9lhpKEMuXYSFMhi2EroOpKyhQa95H2XSC2pPheKlzUgXZKRMgMmSmFTho/dsfQ
	jHAC/B63QoUXXVxk=
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr14406501wmg.46.1627297844030;
        Mon, 26 Jul 2021 04:10:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7uXYEIbwxsAGNQfINHi0ZnA1GqVxem5PtuEFiP4gIupW58zqads79DRLAV8KurpIuhkGLYQ==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr14406492wmg.46.1627297843845;
        Mon, 26 Jul 2021 04:10:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id l23sm26221218wme.22.2021.07.26.04.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:10:43 -0700 (PDT)
Message-ID: <c41c35969415639a6e09036387ebe170da6b6fa5.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: MP_FAIL suboption
 sending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Mon, 26 Jul 2021 13:10:42 +0200
In-Reply-To: <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com>
	 <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Mon, 2021-07-26 at 14:45 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added the MP_FAIL suboption sending support.
> 
> Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> this flag is set, send out MP_FAIL suboption.
> 
> Add a new member fail_seq in struct mptcp_out_options to save the data
> sequence number to put into the MP_FAIL suboption.
> 
> An MP_FAIL option could be included in a RST or on the subflow-level
> ACK.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  include/net/mptcp.h  |  5 +++-
>  net/mptcp/options.c  | 61 +++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  3 +++
>  3 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d0b9e4a7121f..6c8c8592153d 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -60,7 +60,10 @@ struct mptcp_out_options {
>  	u16 suboptions;
>  	u64 sndr_key;
>  	u64 rcvr_key;
> -	u64 ahmac;
> +	union {
> +		u64 ahmac;
> +		u64 fail_seq;
> +	};
>  	struct mptcp_addr_info local;
>  	struct mptcp_addr_info remote;
>  	struct mptcp_rm_list rm_list;

This will conflict with: "mptcp: shrink mptcp_out_options struct". If
this series is merged before the "mptcp: shrink mptcp_out_options
struct" series, I think we can just add the new field here without any
union and do the aliasing the the shirnk' patch.

Otherwise ("mptcp: shrink mptcp_out_options struct" merged first), I
think:

		struct mptcp_ext ext_copy;

should be replace with:
		struct {
			struct mptcp_ext ext_copy;
			u64 ahmac;
		};

mptcp_out_options should not change size that way.

Cheers

Paolo

