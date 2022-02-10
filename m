Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4552C9C
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644504843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZhiARyZmeC+vh8Iz1C8fC0YdOjhhRbvauBKJVV4q80=;
	b=jRCIxyJg2iPZXFwt9/Gzmfq9EVkT8ggCe3bG45WPrIltt8rV8sCgylvTh6GKd0C5OaqFI6
	FgQCJNucWeazNczMv4mQp3/8F+IzyKMhstXPKg/BTrVca6NJJK/XmHIbSvMhrbfDg6pnPq
	lxirMWwHsbRRds8o/bMGNq//MJLuzJw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-w5l6mWCBPZ2JHwFPMQOlfg-1; Thu, 10 Feb 2022 09:54:02 -0500
X-MC-Unique: w5l6mWCBPZ2JHwFPMQOlfg-1
Received: by mail-qv1-f71.google.com with SMTP id c8-20020a0ce7c8000000b0042c12357076so4130715qvo.6
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8ZhiARyZmeC+vh8Iz1C8fC0YdOjhhRbvauBKJVV4q80=;
        b=l2qD21gIZ23y8PIvgID3JnyERQgVQkB6Ex+1JUtlc6pCeQTwZ81NYhZUAAQbM8jrpB
         X0ZaF4zySmnJyW5+IoKElP4ZTEcUhp/7vLhHVPn3WeBGo04ogh6QKrTYBkrMfc3DX62F
         vAjLWiJk/wurRWdhPfr3Ut8sqAMjrD1ZUNQ0fymGNxGFFSYVN3qWxKM2I8i9gYmO0Vkn
         X/eJYndaFafOo1Hid9GNB54vivwBATSVxMDI8Cm+kBV3wYS7CgWZgpOrDlie+9HfruBY
         I+9c+1Sk3nqbocqE2KH1Cfr55F47ZpPXP0wcOqwYnU3T5cWnawa1XVznJOIfurx/JamF
         ef+g==
X-Gm-Message-State: AOAM533+nVzh/xWovXjz4jTSRyUtP6MYjUTrHUWVpzG0aG7P4Hohmg4g
	KX9h8ovp89SnLTCn2TtwZgQ3cQcapAYWdl1QgYpoCRE0nbbFhcE/PBhsuHYFL6q+HeQ2u3QJtU2
	2lURxyPpvJd9Rp9c=
X-Received: by 2002:ac8:59c3:: with SMTP id f3mr678349qtf.201.1644504841392;
        Thu, 10 Feb 2022 06:54:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7nr38jJzRXCM4G4cfUPCKAQm83Md/5OoUg2T1UqLHbZxMQhxyQJaXxlPb/YLCsUGC/VCPxw==
X-Received: by 2002:ac8:59c3:: with SMTP id f3mr678335qtf.201.1644504841102;
        Thu, 10 Feb 2022 06:54:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id bp18sm2036885qtb.72.2022.02.10.06.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 06:54:00 -0800 (PST)
Message-ID: <71915c57b64e6f32480673c03a53a92a72f3fdd0.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/9] selftests: mptcp: join: allow running
 -cCi
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 15:53:58 +0100
In-Reply-To: <20220209212520.2989291-2-matthieu.baerts@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
	 <20220209212520.2989291-2-matthieu.baerts@tessares.net>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Wed, 2022-02-09 at 22:25 +0100, Matthieu Baerts wrote:
> Without this patch, no tests would be ran when launching:
> 
>   mptcp_join.sh -cCi
> 
> In any order or a combination with 2 of these letters.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 66ac990415e6..9bbb95837f73 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2242,7 +2242,7 @@ for arg in "$@"; do
>  	fi
>  
>  	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
> -	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-i" ]; then
> +	if ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
>  		do_all_tests=0
>  	fi
>  done

At this point I think it would be better consolidate argument parsing
with getopts, and dropping the above regexp.

While parsing the test group selectors, we could build the list of 
groups to be executed (possibly a string contaning all the function to
be invoked), and run them after argument parsing - or run all if such
list (string) is empty

/P

