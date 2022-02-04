Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B12F29
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 15:53:57 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id w14so14072200edd.10
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 07:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SNiFjlTvXgTdxODHfmPKjFTP6GDQLqCCZePu8grN5Ok=;
        b=66QBLFIljaCEcTQA6vHP7R4BhC1zTMJA6+1qL619Iy82aNUgTnCvlaEfQZoVwzFzds
         QV/0xIhsVvKd1y4NPrBtNRQlDREqTiiJRFAEmbWT0AtGQ0DVrxvhuwsrg/XOvwgrFbR1
         DWl3+Nwp5LbLWpOXuumZpRRhdNUhyYhW62bc1DdreeNV1HYamHaCk8Hr+5X8nF25qAI1
         DuwNXFVBDDIfDIjm+va2D90xqodGQkdJFXbQGHdRSfKwEHOvVTRabJAZnzvJTLV4MZi0
         PjvWlDNMpAbp5E7q35vNTfrBp141p8pF3HF397ZqrNh3J1cOXph146Z/8HOqiBZEZod6
         eCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SNiFjlTvXgTdxODHfmPKjFTP6GDQLqCCZePu8grN5Ok=;
        b=AmUpIWoUZAzPsXuht3Rq0lSzF7TTXLoComW7OGRuzF8hQwuvxi92/brPDenw1eYQJ8
         +hbWbtZO0v9ptdEAq8ArPry1CrCcWYysDdb8z82DP7BQX/6xx4i1vw66+gpGBeG17nR8
         +16RnIHQJQgHyfjmTiOKxlz65KcZ2hdNb1yyy/KnkstgXrPbHQRk/EI7ECcSNhjwFVz6
         SM5CAiemZDNUP6jRLrxBXYBQNnWfZ2DtsaQRaYsMzMS4Cu/KgwvmNV5iaTtusjB9oAef
         tr87vqcSixKAdBEW6+okw/DryIBBUVwsO7aTboN4uu39z32W3o/kigisMUqpvivyAgZK
         N8UA==
X-Gm-Message-State: AOAM532pWQORM3w5I/MZB+qbE141sgmb9LfXkP7Cl99fTUqLL/VmMB21
	p2EIjK/AASUvvgV+3k6hb9Kp5Q==
X-Google-Smtp-Source: ABdhPJxIZ0xEc12Qmn+vtiBd/5+RZb05g5nRmFH3gj+FvAueyxgnttoWNULYOO/mpxMosn7r0oK5IA==
X-Received: by 2002:aa7:c704:: with SMTP id i4mr3568372edq.183.1643990035429;
        Fri, 04 Feb 2022 07:53:55 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:8033:826e:959c:fd5d? ([2a02:578:8593:1200:8033:826e:959c:fd5d])
        by smtp.gmail.com with ESMTPSA id lf16sm777317ejc.25.2022.02.04.07.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 07:53:55 -0800 (PST)
Message-ID: <932621cc-7db9-91cb-7daf-e37a4953a43c@tessares.net>
Date: Fri, 4 Feb 2022 16:53:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: fix diag instability
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/02/2022 13:17, Paolo Abeni wrote:
> Instead of waiting for an arbitrary amount of time for the MPTCP
> MP_CAPABLE handshake to complete, explicitly wait for the relevant
> socket to enter into the established status.
> 
> Additionally let the data transfer application use the slowest
> transfer mode available (-r), to cope with very slow host, or
> high jitter caused by hosting VMs.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - use wait_for_ instead larger sleep
>  - hopefully better commit message

Thank you for the new version!

It is being tested in the background. More than 175 attempts in a slow
environment with a debug kernel and no failures so far!

> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 2674ba20d524..ff821025d309 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh-
> @@ -119,7 +149,7 @@ for I in `seq 1 $NR_CLIENTS`; do
>  				./mptcp_connect -p $((I+10001)) -l -w 10 \
>  					-t ${timeout_poll} 0.0.0.0 >/dev/null &
>  done
> -sleep 0.1
> +wait_local_port_listen $ns $((NR_CLIENTS + 10001))
>  
>  for I in `seq 1 $NR_CLIENTS`; do
>  	echo "b" | \

Do we need the change the last sleep (sleep 1.5) as well? We could wait
for a shorter time but well that's only 1.5 second once. And I guess we
might need to look for each connection because looking at the last one
might not be enough if there was an issue with a previous one.

So best to keep the "sleep 1.5"?

If yes, do you prefer if the test run for a longer time or can I already
apply it?

Just in case:

Reported-and-tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/258

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
