Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191E2CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641813102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9JBI2wuOQcHBUDKk1GgsK7JCC37e/61xfk0rzz9qEo=;
	b=MPPkeIZAkzHSD+bquysGoFwW6NEdiPvlY8nYsBXQZgZ4AMtSIPhGuZBzAqBFcOYuGeUFDJ
	S0ZgQ/rmVCUBSxQSOFtpoRpTv6OhsWUUieyY1al7xjk7NnD4AMCQVzHJI3G+hK/ygVmXrd
	37CnyXz70ueItmYM73UgeMaShmTIQb0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-hrMB3dwkOwKFcVQNXDr_wQ-1; Mon, 10 Jan 2022 06:11:41 -0500
X-MC-Unique: hrMB3dwkOwKFcVQNXDr_wQ-1
Received: by mail-wr1-f70.google.com with SMTP id k4-20020adfc704000000b001a32d86a772so4081917wrg.5
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K9JBI2wuOQcHBUDKk1GgsK7JCC37e/61xfk0rzz9qEo=;
        b=GLLThNN2m3aCSdRsorBhX6N9jRsVcXf8hOk/TR4p0MxWX0x300W7tPQnqFX3P+r2gC
         VjOA3ChW4aE7UwLfsG0OUDridOJ66cMnWVM1TNtuZOU8/gYkbAJBHbSTh09O2Uqyd6MK
         DlBOo4X4vK9QXM9D2sIyA6iO7zKsTiz5It9PK+KZFTf+koDyvCEkrPSS09aM1WZ8MIry
         e+1fWgAXjLXux7DxHkdjoBtVuC6PGu8iayprRfLiGvjc4heATQJ0aN71cKAlRZSij0V0
         YpxEM4XwuNvv+Rzm0vjD99LkZY1ofsp5OH1Hng4DoUH41bcJ3tVDoZfjkrveyvnqLTen
         napQ==
X-Gm-Message-State: AOAM533YoLLlvrjTWvH9a/YxH0iGqvTqn+vTb1GRnEGZuc/BnPAj90I5
	302+BKzLi6/37hnlz2NV1QUpZPmFluw5WLgGO/tsm7AG73JeFBhhK4sXgrOAYrWu/6G6xX15zbr
	ldckwFEEgb+Z1+4A=
X-Received: by 2002:a05:600c:34c4:: with SMTP id d4mr21914135wmq.53.1641813100077;
        Mon, 10 Jan 2022 03:11:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKZZY+PtJfp/+oyqSFGpQlVPKz3Fl3iVh779/ZdH4AJGQDFvZ8leOtv0e1u+mrS0uOPfTEew==
X-Received: by 2002:a05:600c:34c4:: with SMTP id d4mr21914124wmq.53.1641813099855;
        Mon, 10 Jan 2022 03:11:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id m35sm11448521wms.1.2022.01.10.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:11:39 -0800 (PST)
Message-ID: <263f77b0221bee6a9b99245e8c23f5ebafbe9137.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable
 join tests-cases"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 10 Jan 2022 12:11:38 +0100
In-Reply-To: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Fri, 2022-01-07 at 17:51 +0800, Geliang Tang wrote:
> IPv6 removing test failed on my test every time, this patch fixed it.
> 
> 12 remove subflow and signal IPv6       syn[ ok ] - synack[fail] got 1 JOIN[s] synack expected 2
>  - ack[fail] got 1 JOIN[s] ack expected 2
> Server ns stats
> TcpPassiveOpens                 2                  0.0
> TcpAttemptFails                 1                  0.0
> TcpInSegs                       54                 0.0
> TcpOutSegs                      58                 0.0
> TcpRetransSegs                  2                  0.0
> TcpExtEmbryonicRsts             1                  0.0
> TcpExtDelayedACKs               15                 0.0
> TcpExtTCPPureAcks               23                 0.0
> TcpExtTCPTimeouts               1                  0.0
> TcpExtTCPSynRetrans             2                  0.0
> TcpExtTCPOrigDataSent           24                 0.0
> TcpExtTCPDelivered              24                 0.0
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtMPJoinSynRx             2                  0.0
> MPTcpExtMPJoinAckRx             1                  0.0
> MPTcpExtEchoAdd                 1                  0.0
> MPTcpExtRmSubflow               1                  0.0
> Client ns stats
> TcpActiveOpens                  3                  0.0
> TcpInSegs                       58                 0.0
> TcpOutSegs                      53                 0.0
> TcpRetransSegs                  1                  0.0
> TcpOutRsts                      3                  0.0
> TcpExtDelayedACKs               3                  0.0
> TcpExtTCPPureAcks               29                 0.0
> TcpExtTCPTimeouts               1                  0.0
> TcpExtTCPSynRetrans             1                  0.0
> TcpExtTCPOrigDataSent           24                 0.0
> TcpExtTCPDelivered              26                 0.0
> TcpExtTcpTimeoutRehash          1                  0.0
> MPTcpExtMPCapableSYNTX          1                  0.0
> MPTcpExtMPCapableSYNACKRX       1                  0.0
> MPTcpExtMPJoinSynAckRx          1                  0.0
> MPTcpExtAddAddr                 1                  0.0
> MPTcpExtRmAddr                  1                  0.0
> MPTcpExtRmSubflow               1                  0.0
>                                         add[ ok ] - echo  [ ok ]
>                                         rm [fail] got 0 RM_ADDR[s] expected 1
>  - sf    [ ok ]
> Server ns stats
> TcpPassiveOpens                 2                  0.0
> TcpAttemptFails                 1                  0.0
> TcpInSegs                       54                 0.0
> TcpOutSegs                      58                 0.0
> TcpRetransSegs                  2                  0.0
> TcpExtEmbryonicRsts             1                  0.0
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e48ce23d2386..41a2510e2f97 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -393,8 +393,8 @@ do_transfer()
>  				do
>  					id=${dump[$pos]}
>  					rm_addr=$(rm_addr_count ${connector_ns})
> -					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
>  					wait_rm_addr ${connector_ns} ${rm_addr}
> +					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
>  					let counter+=1
>  					let pos+=5

Uhmm.... this is equivalent to replacing 'wait_rm_addr()' with 'sleep
1'. It defeats the purpouse of wait_rm_addr itself: reducing the delay
required for 'del address' related operation. Additionally, an
unconditional 'sleep 1' could impact negatively in other test-cases.

Possibly some alike:

---
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..b209a303d1fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -366,7 +366,7 @@ do_transfer()
 
        # let the mptcp subflow be established in background before
        # do endpoint manipulation
-       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
+       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 2
 
        if [ $addr_nr_ns1 -gt 0 ]; then
                let add_nr_ns1=addr_nr_ns1
---

could be more appropriate, but 2secs to complete MPC + 2 MPJ HS looks
really too much...

Can you please capture a pcap trace with the failing test?

Thanks!

Paolo

