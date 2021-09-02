Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF72
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630572881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVzZ+7ah4+NX7o2llxNHL7nCj8ew1Fxhp+zF3M0Ck0A=;
	b=aM8g5c6/7EdXxCbTGneYAdj8oDMrT3kqc5TWe6RpxB1Y2R6klTi0kKzfZOf1g5N4p5SGRL
	7GKxELmSy0iFH44Ht54rbdWdpryUPlLKs08q814Kp18aINe3CjBIQ/SewU0G1avdF+w4+Z
	tQ+dN0GwMR6Sc88dIUhFS2nMFYGuKy4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-RkMe9KA0Ovixgb92XPSjOQ-1; Thu, 02 Sep 2021 04:54:40 -0400
X-MC-Unique: RkMe9KA0Ovixgb92XPSjOQ-1
Received: by mail-wr1-f72.google.com with SMTP id p10-20020a5d68ca000000b001552bf8b9daso301700wrw.22
        for <mptcp@lists.linux.dev>; Thu, 02 Sep 2021 01:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zVzZ+7ah4+NX7o2llxNHL7nCj8ew1Fxhp+zF3M0Ck0A=;
        b=LUFL1SE+xYCLKCM1C76kZfF9ZUXpjLNlqd5dsgn8VVvGe4QWq8W0VyQrWj3bD8r97m
         Ob6sj7z9wdBh8pPpejNt/J8rR0dVXl+tDTYIO3o2u+CTdzaXU3rzNNJBwkyM+BA3uekR
         s7RDheTkfXGq29xBhzXqRXM8bCYrEUbyGgCLLhbT0bbL1r8EOnRNVuTQ/xBCLgTgi+nV
         7SBx6nBFbQUQDEQ5n5DRBdK6TG850qGLtXCP7oUTNghmzce9GiCiKlzI+0vcVaYCwuvD
         r8TNdn44vPO13vq1Azls2B9N+tMG7vxDiry62qhiy3ZfShK2mqA/1+Q3vOoDobk1IbIX
         p1Xw==
X-Gm-Message-State: AOAM531daezLt9lEbfaDB1vDB7G1VqkAMqF2BHPiOrgD+SCzg0VfKiSi
	uBXYe15dxKK2DJWb10x8M1XfdktFL4CYUPg1el7Y9i29VYn/s4hJ18n/WgekymATTMbyBadnWju
	X7ANNnxZ+1oxBqRg=
X-Received: by 2002:adf:fec5:: with SMTP id q5mr2358850wrs.153.1630572878800;
        Thu, 02 Sep 2021 01:54:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbqtJ7MAjv2CIW++S3F05watEshsQWlP1Pwya639h/p7VV1nwMK7a4uUiOgHoB0RLrNuPFHA==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr2358839wrs.153.1630572878629;
        Thu, 02 Sep 2021 01:54:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id u9sm1213913wrm.70.2021.09.02.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:54:38 -0700 (PDT)
Message-ID: <98e2161d07672085b36593e8854ba14e519fdd15.camel@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: use OPTIONS_MPTCP_MPC
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 02 Sep 2021 10:54:37 +0200
In-Reply-To: <213e62f81b8daf3309039a0679a6925c5122b0b2.1630565830.git.geliangtang@xiaomi.com>
References: <213e62f81b8daf3309039a0679a6925c5122b0b2.1630565830.git.geliangtang@xiaomi.com>
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

On Thu, 2021-09-02 at 15:00 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> Since OPTIONS_MPTCP_MPC has been defined, use it instead of open-coding.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/options.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1ec6529c4326..cf4ef11916c9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -749,8 +749,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
>  	 * 'backup'. Also it makes no sense at all
>  	 */
>  	if (!subflow->send_mp_prio ||
> -	    ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> -	      OPTION_MPTCP_MPC_ACK) & opts->suboptions))
> +	    (OPTIONS_MPTCP_MPC & opts->suboptions))
>  		return false;
>  
>  	/* account for the trailing 'nop' option */
> @@ -1327,8 +1326,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
>  			}
>  		}
> -	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> -		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> +	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
>  		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>  
>  		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {


Nice clean-up! LGTM! 

Acked-by: Paolo Abeni <pabeni@redhat.com>

Side, note: I'm wondering if we should additionally switch-out of yoda-
style? 

e.g.:
	opts->suboptions & OPTIONS_MPTCP_MPC

/P

