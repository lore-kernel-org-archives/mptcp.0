Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E36EED6
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208752; cv=none; b=oggs5+cjs4hcWqh+ReUb46Gk/pNtYsUUi2rT+uCeAFXNoz6DSO1HcYwOWSD0wY6/Iznj6pduJBWLnypEjRO+xmnDNSS5sd4Et5Fj/Rnwyj4vyjVA9fDOQyUvPl5iGhSY3RwwBS9DMvPaag7/QE/cfIV+6kDaXpQWqd52iEXyakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208752; c=relaxed/simple;
	bh=bfhKc9uwY8Ze2S43IZ7bwOCzbZHy7WzyBJdS1VyZgMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEKYbERaMh31qFh5RoasjY3x8BlmX2JRKUXLHNyMqbftTDx0YLohU7sl/6R5x2wqobfVVWqQLEBTRbaCtOjVT4cAtriZVkwxK8CQ8KCh8cjCCCULRGhft9AReDvlu2brN6gGSwXBDE2TgECiuVJLh1sABh1V2xw2jeyiLomPFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWxuYefg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWxuYefg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742208749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVsPX/MsnZEZWXNhYsFbGocN1T99uK+ljLJqDobjt2I=;
	b=LWxuYefg+xB1+HxxCw+9nFt1H0bS2jxqqspD6owfIvxqamx4pgxvESPtg1AczBhGCw1YXj
	xfpLAuT9cbmPguyOsdqYdtOeGfKKrTqszKHt1v6lTzjhnzPRfkXgsJGc/Um+B9tbdoC1id
	wt4ZDkwIBAkqso9d641+wRGqzMJuAm8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-bDCLLRtmNP-6-q6jInJ_zA-1; Mon, 17 Mar 2025 06:52:28 -0400
X-MC-Unique: bDCLLRtmNP-6-q6jInJ_zA-1
X-Mimecast-MFC-AGG-ID: bDCLLRtmNP-6-q6jInJ_zA_1742208747
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912580843fso3287289f8f.2
        for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 03:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208747; x=1742813547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVsPX/MsnZEZWXNhYsFbGocN1T99uK+ljLJqDobjt2I=;
        b=n48oCGSPTrjd0PftPiEYlkCTVN2lsCqg3/RhGDtCwG5kiQ5HgZkJ8ctRuFsyPzz4/r
         mdgDIR+tvPHstubMobanf5h9GEmkrAk7sk9bSlQmyQQdL8vI4GR1p5eUlfSprMjgna9J
         9cz03/V50ucUU98HvluwvzxXFd7o6AJtMZhnsMRH4/qic6ybMhqWR8lBEV5nGMjfNg2t
         1x0LEjO7dttTkY5lEpxQPWGH0eUwtbYTS4WDMYcVsiWjZ1HYs3uiLeXfac7g49HCid/X
         CXo7Ey12YzQEvH2+HpADvXC+mTUUxI4MQDZNIao+1jzxMgRiUP4RkrmoWz0eMh2IRzmw
         uxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvbtMLdW8YX1m1KXX+WOyMVPagLvMK7fDUR7Uqmdl8X3XHfVx5k3vXeBNjt5YD5y58JuRrnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoaNMmX6DuYm+3aMRgofb2F9UVMvqUHW12VHNjBB/o2guo9axN
	1VeW62H7hDMvTZk+R2ZiUr7Gf5AQUPcya3VeWmISZZP89OQT/0QQQgdLwI56JFPRGxAiWkj0aqZ
	PZm71WJun/WucushgFhWbGjMCN2bu32khJPoQ0X1uaxSkOiYOrVu1
X-Gm-Gg: ASbGncuKhjwbV+mPOFF+jr+yhdgqJ75kENsTEKdTu7seJkfZMhwflqHT4pubuivQX/1
	XjDvmsErhN2IcR8XRqKWiMcFvSellReSe2ZeQcGlk82DzrY4jSHgWbiPksKUofNWNlWvfO5PFvj
	KrFpyp5wSL6lquu6UxiuOOnVbZXrcAa1US8GfLHO2znNX7vOEoNQCRuhCdfbKP7AjMO3BpXMWCB
	CV8UOgKH+jO0fiYLFDJVYj2O3qeuU9kJ1MKPSR0n8lcdIZtpta0QJlL1E1KENdxi4Sl13cvhejV
	FAI5pezfPyHKgRJYbqr3+hGY8laaEk26uMGKWirnMMFA1A==
X-Received: by 2002:a5d:584d:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3971d8015d6mr12287867f8f.25.1742208746771;
        Mon, 17 Mar 2025 03:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtFhyJOcklHLJ5YSN+FBHLAJeVIgHUs0LyATP3ThZ8i7U0b4zr717XAYLmzgLLv6bZh1Ge6g==
X-Received: by 2002:a5d:584d:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3971d8015d6mr12287857f8f.25.1742208746374;
        Mon, 17 Mar 2025 03:52:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df413esm14304018f8f.20.2025.03.17.03.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:52:25 -0700 (PDT)
Message-ID: <e6dd5585-cc88-435f-83c2-2c40fdf7b356@redhat.com>
Date: Mon, 17 Mar 2025 11:52:25 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mptcp-net] mptcp: fix NULL pointer in can_accept_new_subflow
To: Gang Yan <gang_yan@foxmail.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <20250304102634.331497-1-yangang@kylinos.cn>
 <3ca5355f-d449-4540-9707-e54c6715d0df@kernel.org>
 <tencent_C5EC2504BB7561514BCABC185027C5324008@qq.com>
 <e1c36a29-7f27-4c2c-8dba-778e4ea5c7ae@kernel.org>
 <tencent_F7B3BAC3285B65240C959317991676180207@qq.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_F7B3BAC3285B65240C959317991676180207@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YSxvI6V9IEbJL4WuvBJkooNo8ZdzOyTlKChvzRjveBs_1742208747
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 11:30 AM, Gang Yan wrote:
> There have been new developments on this issue. I added some kernel logs and
> have now basically pinpointed that 'subflow_req->msk' is being set to NULL
> between '!subflow_hmac_valid' and '!mptcp_can_accept_new_subflow'
> ...
>                 if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
>                     !subflow_hmac_valid(req, &mp_opt) ||
>                     !mptcp_can_accept_new_subflow(subflow_req->msk)) {
> ...
> Although there is a NULL check for msk in the subflow_hmac_valid function,
> there is still a risk of 'subflow_req->msk' being set to NULL later on.
> 
> After several days of research, I captured some useful kernel logs which show
> that within a very short period of time, req:000000002a5ce31d executed
> 'subflow_syn_recv_sock' twice, which seems strange:
> 
> ...
> MPTCP: subflow=00000000f90ffe23
> MPTCP: msk=00000000ec710aab
> MPTCP: msk=00000000e7247175 state=1 flags=0
> MPTCP: msk=00000000e7247175 state=1 flags=0
> MPTCP: MP_JOIN hmac
> MPTCP: msk=00000000e7247175 dfrag at seq=8532131614574795419 len=6 sent=0 new=1
> 2025-03-12T08:44:48.321697+00:00 MPTCP: listener=00000000c5bcffeb, req=000000002a5ce31d, conn=00000000d1c8e3bb
> MPTCP: MP_JOIN hmac
> MPTCP: msk=00000000e7247175 ssk=00000000cefa72e6 sending dfrag at seq=8532131614574795419 len=6 already sent=0
> MPTCP: data_seq=8532131614574795419 subflow_seq=1 data_len=6 dsn64=1
> 2025-03-12T08:44:48.321698+00:00 MPTCP: listener=00000000c5bcffeb, req=000000002a5ce31d, conn=00000000d1c8e3bb
> MPTCP: subflow=00000000501691f6
> MPTCP: MP_JOIN hmac
> MPTCP: msk=000000002e70bde0, subflow=00000000501691f6
> MPTCP: msk=000000002e70bde0 subflows=5 max=8 allow=1
> MPTCP: YGYG First step run and step3 cause req:000000002a5ce31d msk:0000000000000000 is NULL
> MPTCP: DSS
> MPTCP: MP_JOIN hmac
> ...
> 
> And this proves that if 'subflow_req->msk' ownership is transferred to
> subflow in the first execution,  there will be a risk of a null pointer dereference here. 
> Unfortunately, I haven't found the reason why 'subflow_syn_recv_sock' is executed twice.
> Do you have any suggestions for me?

The client can retransmit the syn ack for multiple reasons. Even if the
packets are transmitted with a relevant time interval, they can be
processed by the server on different CPUs concurrently.

Unlikely (or even extremely unlikely) but possible.

Note that the MPTCP and the TCP code protect vs such race using the
`own_req` boolean. Only a CPU/thread sees 'own_req == true' and only
such thread is allowed to modify the subflow req struct.

Unfortunately your suggested patch does address the issue completely.
Onother CPU could still clear subflow_req->msk after the last check.

A better solution could be moving the subflow_req->msk under the
`own_req == true` conditional:
---
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index efe8d86496dbd..f3948c63c17a5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -754,8 +754,6 @@ static bool subflow_hmac_valid(const struct
request_sock *req,

 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;

 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -850,12 +848,8 @@ static struct sock *subflow_syn_recv_sock(const
struct sock *sk,

 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
-		    !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
-		}
 	}

 create_child:
@@ -905,6 +899,13 @@ static struct sock *subflow_syn_recv_sock(const
struct sock *sk,
 				goto dispose_child;
 			}

+			if (!subflow_hmac_valid(req, &mp_opt) ||
+			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;



