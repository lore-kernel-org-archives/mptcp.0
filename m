Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C972568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645434286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZOzbxKgYn1fBPueSfgqjZ9OhGA6Yd0Lr9omh3NbU0E=;
	b=GOe7+LC3N/PtvasqttGGtAKF2O/YRADZMyZguohUib9/nuxKuzvXg90VY30gkxvUmIQkIm
	kCg/spL2nIHVPg16CfJHH6Qg5bf8w5RuAQ46CSpON4zh4twGWdnbihVybWFdjpiojzpDFO
	ePnc6+PMWqcYxS2R7FTv8vtHFin51XE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-rCcQL-ccPg60_n2CfJvwDQ-1; Mon, 21 Feb 2022 04:04:44 -0500
X-MC-Unique: rCcQL-ccPg60_n2CfJvwDQ-1
Received: by mail-wr1-f69.google.com with SMTP id q21-20020adfab15000000b001e57c9a342aso7113922wrc.6
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 01:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cZOzbxKgYn1fBPueSfgqjZ9OhGA6Yd0Lr9omh3NbU0E=;
        b=TBnEYykilwNDuEHxCzjtQKrFGHQWoRaoYi6a2/H+xZO6kK8YgC3RWbfwQvkJgDG7W/
         aTp5Nu0JXi3gvFgbxSAvuiQE2lgmjaoNipWJ4cdpBa77zgalMdvhVHhBb7SOaIZEm4zc
         v9OtC96gEoMgshcsYFMq1v2hOi2ogZbVIyp4qB55atwZsGHESRDu4SnphKSCeGkFfpPl
         z86BG2cK/vXs/wts5eRxULMxIl9ICDXI9XkKtnu08jp+8SWnonKYN3UdowuboEFG3XXl
         0WQ6DMysgWHCyLx6pSzR0y1UvR7g7ukgfwxWSpF3Eoram+bt8j7+SslwdmzJBk8gZyKG
         +SuQ==
X-Gm-Message-State: AOAM531sOOK9Hmux+X4r+MNzH+jy0ipHVvKFI5t3IdwY5t7u+zmyLXwE
	jMClCjKvPxlny6dpZgy+XcTtt0rvz1Q6AGoHNyKkg+RkZG2uNupKdDaVxRC3v8mOCeEFRm48s0m
	28eb4IsM6X0MO/Ig=
X-Received: by 2002:a05:600c:3ba0:b0:37b:b86a:5d30 with SMTP id n32-20020a05600c3ba000b0037bb86a5d30mr20240383wms.136.1645434283155;
        Mon, 21 Feb 2022 01:04:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxR93R8QWOqXUhfrRPEt5nx+sw2/mxbp7qJACSD5jpHFRodfNklP92PIm6GbER72i8j3dhQdw==
X-Received: by 2002:a05:600c:3ba0:b0:37b:b86a:5d30 with SMTP id n32-20020a05600c3ba000b0037bb86a5d30mr20240366wms.136.1645434282896;
        Mon, 21 Feb 2022 01:04:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id 2sm25804247wry.4.2022.02.21.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 01:04:42 -0800 (PST)
Message-ID: <926e1f3660c8cec0e551437d63b3ad3245b13f86.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: Rename wait function
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Mon, 21 Feb 2022 10:04:41 +0100
In-Reply-To: <20220218221814.72026-4-mathew.j.martineau@linux.intel.com>
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
	 <20220218221814.72026-4-mathew.j.martineau@linux.intel.com>
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

Hello,

On Fri, 2022-02-18 at 14:18 -0800, Mat Martineau wrote:
> The "selftests: mptcp: improve 'fair usage on close' stability" commit
> changed that self test to check the TcpAttemptFails MIB instead of
> looking for TW sockets. The associated bash function wasn't renamed in
> that commit because of the merge conflicts it would cause, so this
> commit updates the function name as Paolo originally intended.
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 491934c3c489..71b2ad5adefc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1152,7 +1152,7 @@ chk_link_usage()
>  	fi
>  }
>  
> -wait_for_tw()
> +wait_attempt_fail()
>  {
>  	local timeout_ms=$((timeout_poll * 1000))
>  	local time=0
> @@ -1271,7 +1271,7 @@ subflows_error_tests()
>  	TEST_COUNT=$((TEST_COUNT+1))
>  
>  	# mpj subflow will be in TW after the reset
> -	wait_for_tw $ns2
> +	wait_attempt_fail $ns2
>  	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  	wait
> 
I'm late here, sorry.

I'm ok with the patch as is.

Thanks!

Paolo

