Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A572
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627492873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw4dCMWx9c8ZEp756CVje7su+Wmwcqo4NfWVnlVVw60=;
	b=RoT/1Nr6qAC/1ofNeISFzeGKmkT8fC6YhNVSjLtfv2ihiCv+5D4rJd4v9FLBSkwnB5uHl9
	kWObtr8Sb8SSoLSc5QJctovLgFvbDkUMvTw+zpllsoaPEo8WkYZ3yRkHlz9qLQZ8r6Uubw
	ihc/TlUzQP7+ENdZbrc84d1v9pmDCo8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-wexTgAaoO6OrbVIbS6LPzg-1; Wed, 28 Jul 2021 13:21:12 -0400
X-MC-Unique: wexTgAaoO6OrbVIbS6LPzg-1
Received: by mail-wr1-f69.google.com with SMTP id r17-20020adfda510000b02901526f76d738so1200045wrl.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Xw4dCMWx9c8ZEp756CVje7su+Wmwcqo4NfWVnlVVw60=;
        b=Vud6BdrtXiywAbH8pgNkQE0dXpaTMmegy8SHzHuU2NF7XGsNq/80iM3EbiFKwGF4/s
         vjYqKN+9CGP1Iwh9uWpoNZgAtx+pHuyrucAF4WwRCsoYcx/P/a2CTe9wUd5lnDsLalk7
         mGzzxa3DrLoSGtr6XqjmXIj8eAVl1Ccct91kcr5bfTuUUWbGNQgTxQ+/Rh4QnJebISM4
         kGnt9tNremiL6yzL9BpU6nLm5BsZB1nO7cqpVosWXLTxsHlMO0sIlV4UprrgckwXuvNX
         WTG1sjkBv1BMTsFjOYuebcpK3qOF65oUiovrvxD3cRybobc2+NFhBrUM9BzNJCSl+wOW
         l/wg==
X-Gm-Message-State: AOAM532NLEWYMPa+S5s8j388/9bMuN6l0SGWLl5OQb42N+C4n4Lh2sjO
	j7fHtAPPKTnQoqDQWlL9eXYtfpqCOE7p7RNqkDgcqQGqK3awF4HNHOL9ig/ruPDs+GGyIBBgLGN
	GzD3ecfdiArz1wd0=
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr457728wrn.398.1627492871032;
        Wed, 28 Jul 2021 10:21:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz62b84k+eAGyF0y4y0FOu9rUvujqWERcU8d9w0Ftt/XFwvZhkOKGc3uGZ/KYVL4vTqQIV1iw==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr457713wrn.398.1627492870900;
        Wed, 28 Jul 2021 10:21:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id w18sm476196wrg.68.2021.07.28.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:21:10 -0700 (PDT)
Message-ID: <44581bdbef617928052995d5e7ec0a6420023f9b.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 4/5] selftests: mptcp: add fullmesh
 testcases
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Wed, 28 Jul 2021 19:21:09 +0200
In-Reply-To: <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com>
	 <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com>
	 <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com>
	 <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com>
	 <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
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

On Tue, 2021-07-27 at 21:24 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added the testcases for the fullmesh address flag of the path
> manager.
> 
> Reuse the above 10 address numbers for the fullmesh test.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 937e861e9490..2a27d6240f5b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -367,7 +367,13 @@ do_transfer()
>  	fi
>  
>  	if [ $addr_nr_ns2 -gt 0 ]; then
> -		let add_nr_ns2=addr_nr_ns2
> +		if [ $addr_nr_ns2 -gt 10 ]; then
> +			let add_nr_ns2=addr_nr_ns2-10
> +			flags=subflow,fullmesh
> +		else
> +			let add_nr_ns2=addr_nr_ns2
> +			flags=subflow
> +		fi
>  		counter=3
>  		sleep 1
>  		while [ $add_nr_ns2 -gt 0 ]; do
> @@ -377,7 +383,7 @@ do_transfer()
>  			else
>  				addr="10.0.$counter.2"
>  			fi
> -			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
> +			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
>  			let counter+=1
>  			let add_nr_ns2-=1
>  		done
> @@ -1697,6 +1703,46 @@ deny_join_id0_tests()
>  	chk_join_nr "subflow and address allow join id0 2" 1 1 1
>  }
>  
> +fullmesh_tests()
> +{
> +	# fullmesh 1
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
> +	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +	chk_join_nr "fullmesh test 1" 4 4 4
> +	chk_add_nr 1 1
> +
> +	# fullmesh 2
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow

It still took me a bit follow topology creation here. I think a comment
is deserved, the first time this kind of argument is used.

Additionally, I suggest to use the "12" as an argument even in the
previous test, dropping the explicit endpoint creation, for
consistency.

All the above could use a squash-to patch, as this is the only minor
thing I have to comment for the whole series.

Thanks!

Paolo

