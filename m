Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96153E2760
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911782; cv=none; b=Yca+3LkjksSfl40Jy29ra5VlHFT/maPbCqaxsXH9KCGt636z182VI5JkZX92rf7eQhnAMGMsiK+efSJhvBon/1A6zC8GWiGDoow7DavKFC9wDaeOdqINdbbiqMSvByllYRSfwFJU7rGJnzT1P/sjnH/cUSuPr2JCq2NShJHkGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911782; c=relaxed/simple;
	bh=qT+Ees0rjCkEKOzWbdSyB0zF8UysDUeMHzydR8Wg6L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHtkVYnrHXLsk7Eznbeez0gCvc3STQ77/Bes/nTqm7BeFtzmd1fea11G+/yWy71CkruSMy9OUYLVw1PN4RDYTPSTIBHugS5UwDXMLdv7Rlif4T/bC8dG4I1jibUNh0f/FQIVOR8bK/qRr3LWKRJcpuCDi0htL5BQWPFp+BHEFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/asoQMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/asoQMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777911779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbA7+8QpDGxjOj6n2LhHl4EyIokUrPpu6BYjMXA7qrk=;
	b=c/asoQMaGiYcOm2FAjIjK2u1+yv0EKHX+M7ulIMV5NsLC20mUizeABFWuPo7vFFeoqnrE7
	FVtKvu86OEPQmN3j+jyO5CC/9fwxfJwXEBirV2Dny3waLBU3cYMK/2J1Z/xI4CSaD3Mi67
	jsiY9bJgnrrSnLr5Ise041tOi8I0o/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-tKCEdlEjPreWvKGVA82fuA-1; Mon, 04 May 2026 12:22:58 -0400
X-MC-Unique: tKCEdlEjPreWvKGVA82fuA-1
X-Mimecast-MFC-AGG-ID: tKCEdlEjPreWvKGVA82fuA_1777911777
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso54306255e9.1
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 09:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911776; x=1778516576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbA7+8QpDGxjOj6n2LhHl4EyIokUrPpu6BYjMXA7qrk=;
        b=s8rIlzlN1PZ2zpuz0jVznNCh4WStd5M1lDb85NahTviaJafJCNZPfG9A+3LMhj4sRS
         DnnnuGPMFNJueJBaLRFTjer+Y5FdfGaAwyXNCUbS9lWwlkwMXDR0X37tn211GrCAEkUk
         d3bROecG9XjWy9I82qMz2IRBA7HBq0xE8N/uU/Bjl5sQxx2WjLEhOIHV7NvqHHTYjnuK
         kLlSUGFDQDZHl/5yEDh8sLVzypegRKw20fjdYiVTO39O70RZ5Lex1XWz7uejN7Lqgt+F
         hRlpF94gl40N8zF98uAseyqfUVxoYpEEglCv94hxCa/ci0Fj3giqGJnyMSY6+30yNXkP
         EekA==
X-Gm-Message-State: AOJu0Yxm7wDC5dMxTM1SYExkknxOtCYFBQJKV8OAwGK35MMYDtpREaO+
	n2TjzkcRNGUsETof5wlX6xhKsogBuczBTWrFhD7ahQwfPfuBJ+iW8SBijlSi7u9JcMmOVVr9OCn
	KEx5bsY5vrig0m/3rvtyO7T7IUT8UNpE0KUcBXGrkVMKpP/dKnR8WeHVPYxxd/hXyy+SGBfrxQy
	ISfhNBoMUjiHa9IKCcHSFnGuLdZL5gUdWCedxlBg==
X-Gm-Gg: AeBDiettIyyLs/JrVBPTQKJYDip6UgbyZK06fk4ETUX980AtBX/3YJTFpENJfXGx02l
	EChidD/t1fncgeFqR3d5aTuvQt2D0ElQpEW0CaBBmqHz8ThnwQiaAfjOHBzM3ZZQoE9XMqH5iUQ
	hxhL+NyWHk9UJTgoeyVd+pk3a2IprWSSZnm0RSBc1zQFvuMap7u4accStCw5vrM0OcOU20c/bRk
	8hZLx3bDgCML768P7zlc0QDPSxmoZQlWAXFblIe+bXirx8ug0MfRc7RiZt2BIs6st8qoqbEdXNK
	58WQeZJ6/M6A4+bfiNdbnKXQNIeEMWWP0EKutvfTys7mpcP1ZsKmPZJkBf3cDRjfAqNZryeukAo
	HtSHF8n3F37xFTy5LI4of+aB6bv5/obTVeo8tMXjBoignxioTamOPF1wN0bFCNbxhGQ==
X-Received: by 2002:a05:600c:1604:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48d0562f7efmr58636315e9.27.1777911776379;
        Mon, 04 May 2026 09:22:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1604:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48d0562f7efmr58635895e9.27.1777911775894;
        Mon, 04 May 2026 09:22:55 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm598766715e9.2.2026.05.04.09.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 09:22:55 -0700 (PDT)
Message-ID: <5841afcc-13ea-4bee-8645-634a02e76c4f@redhat.com>
Date: Mon, 4 May 2026 18:22:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: fix KMSAN: uninit-value in
 mptcp_established_options
To: mptcp@lists.linux.dev
Cc: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@google.com>, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
References: <69f44505.050a0220.3cbe47.0008.GAE@google.com>
 <20260504095101.852039-2-matttbe@kernel.org>
 <67030b5e-0435-49fc-8adb-8dd8536ad853@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67030b5e-0435-49fc-8adb-8dd8536ad853@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MiCNfecPApso1r3E2PHv7O-Iv61TX_XhkTvGthofZL0_1777911777
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/26 11:59 AM, Matthieu Baerts wrote:
> 
> Sorry for the noise: I forgot to add the syzbot instruction... (and I
> forgot to remove the MPTCP ML from the sendmail.to option).

I did not take in account all the possible corner cases.

Let's be a little more conservative.

#syz test
---
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e4..0763fd6f7758 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -27,6 +27,9 @@ struct mptcp_ext {
 	u32		subflow_seq;
 	u16		data_len;
 	__sum16		csum;
+
+	struct_group(flags,
+
 	u8		use_map:1,
 			dsn64:1,
 			data_fin:1,
@@ -38,6 +41,8 @@ struct mptcp_ext {
 	u8		reset_reason:4,
 			csum_reqd:1,
 			infinite_map:1;
+
+	); /* end of flags group */
 };

 #define MPTCPOPT_HMAC_LEN	20
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..3fd40dbff82b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -572,6 +572,11 @@ static bool mptcp_established_options_dss(struct
sock *sk, struct sk_buff *skb,
 	bool ret = false;
 	u64 ack_seq;

+	/* Zero `can_ack` and `use_map` flags with one shot. */
+	BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_ext, flags),
+				 sizeof(u16)));
+	*(u16 *)&opts->ext_copy.flags = 0;
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;

@@ -595,7 +600,6 @@ static bool mptcp_established_options_dss(struct
sock *sk, struct sk_buff *skb,
 	/* passive sockets msk will set the 'can_ack' after accept(), even
 	 * if the first subflow may have the already the remote key handy
 	 */
-	opts->ext_copy.use_ack = 0;
 	if (!READ_ONCE(msk->can_ack)) {
 		*size = ALIGN(dss_size, 4);
 		return ret;

