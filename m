Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496D2110
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651657955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jK2MsXqYmnZvgTYd3n2asceemgHjlgfFwZH1Xo2dfG8=;
	b=JDMVjdNkL9pBAjIYfSG0sNJViUacG1T58OlXnQh/yJdDwjfZm/Ye0rYff6OgQJTzlm+3Yw
	4MWCRlL/KJNRoj3epslZo5n8R87yv6A7boikn2snA2xNZoP0cUc5DBGkXio3tRR8RPwmmP
	NPAmbq2WR1JM9u3rnaHqbQ5Gw3/8WcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-Z_UF19ccPGq7GqWRb0TU0A-1; Wed, 04 May 2022 05:52:26 -0400
X-MC-Unique: Z_UF19ccPGq7GqWRb0TU0A-1
Received: by mail-wm1-f71.google.com with SMTP id j5-20020a05600c1c0500b0039419a269a1so481209wms.3
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jK2MsXqYmnZvgTYd3n2asceemgHjlgfFwZH1Xo2dfG8=;
        b=Xv5owY6C36UnLuNtxbQ40Lw8qTkF6nInkxKD/LP5m3CzzOsGJ1IDODqO+SO2C+zeDw
         T61GDu023LSV8veMY3WwpiMIHExYlWuO7VloYrZOPZP9CvNTi8pVMOCZ6DsJF2E7FGT0
         c5Bba2Y5FOo0K4SyLdWTS4LWJu5/2otzGRD5YCV2h7rOio4+Llw8s1iGfrEojE5p0mhg
         7Ii1PiotIpepl74ttTlviy/AXmJ1jsetVRcgXm+TGWTKzvIrBEHgURmYg8ty+Pg+7MO8
         STmw8VoFQOlFFOwwixHnBqtJJMDg3Q3VKZaCXxbgNtMT1T1O7CiFdGMu1jIgb2pfDBb9
         z4mw==
X-Gm-Message-State: AOAM530h+H8AkggcWEidWilUFRO2/ySpvBlmWrMcjFT0Egqk4MQb1jfG
	+UQl1HYRBtpDd3hK0AABDNR+teKYwjGff+8T0NB52WUrfJ7WN6r1oRCeh/mZf3Dux7v2ECsh9E5
	WchizxjcEhEA5NGQ=
X-Received: by 2002:a7b:c74f:0:b0:394:1ce3:cc42 with SMTP id w15-20020a7bc74f000000b003941ce3cc42mr6785473wmk.153.1651657945545;
        Wed, 04 May 2022 02:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt+X5HBf55eZwvDW0d1J5WwNOrkrILXOf47L1IS8ZtLIaGt1hKTVQbymqTGoEW8oGbKpERcw==
X-Received: by 2002:a7b:c74f:0:b0:394:1ce3:cc42 with SMTP id w15-20020a7bc74f000000b003941ce3cc42mr6785449wmk.153.1651657945241;
        Wed, 04 May 2022 02:52:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id r7-20020adfab47000000b0020c5253d8d5sm10689510wrc.33.2022.05.04.02.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:52:24 -0700 (PDT)
Message-ID: <e69d4d2bead08317ad3af55ffe415b8f94877948.camel@redhat.com>
Subject: Re: apropos
 https://github.com/multipath-tcp/mptcp_net-next/issues/265
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Galaganov <max@internet.ru>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Date: Wed, 04 May 2022 11:52:23 +0200
In-Reply-To: <c1513b33-add8-3e16-d14d-0b1886061040@internet.ru>
References: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com>
	 <c1513b33-add8-3e16-d14d-0b1886061040@internet.ru>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Tue, 2022-05-03 at 23:41 +0300, Maxim Galaganov wrote:
> On 29.04.2022 13:08, Paolo Abeni wrote:
> > I think should see sistematic csum failure when the involved peers have
> > different endianess (e.g. x86 vs arm). If anyone has easy access to
> > both systems, could please verify the above?
> > 
> 
> I've built OpenWrt from current master (4509b79) for ath79/generic with 
> CONFIG_TESTING_KERNEL=y
> CONFIG_MPTCP=y
> CONFIG_MPTCP_IPV6=y
> 
> and flashed it onto TP-Link Archer C7 v5.
> This is what I can observe with a simple echo server and nc.
> 
> Client:
> % uname -r
> 5.17.4-200.fc35.x86_64
> % lscpu |fgrep ndian
> Byte Order:                      Little Endian
> % mptcpize run nc 192.168.2.1 12345
> qwerty
> Ncat: Connection reset by peer.
> 
> Server:
> root@tpa3:~# uname -r
> 5.15.35
> root@tpa3:~# lscpu |fgrep ndian
> Byte Order:          Big Endian
> root@tpa3:~# sysctl -w net.mptcp.checksum_enabled=1
> net.mptcp.checksum_enabled = 1
> root@tpa3:~# ./echo 12345
> Server is listening on 12345
> ^C
> root@tpa3:~# nstat 'Mptcp*'
> #kernel
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtDataCsumErr             1                  0.0
> MPTcpExtMPFailTx                1                  0.0
> 
> The issue goes away when I set net.mptcp.checksum_enabled=0 on both 
> ends. Please tell me if you need more info.

Thank you very much for the testing! That has been very helpful!

Indeed we have serious problems :/

Could you please additionally test the following patch? Kernel for both
arches must be rebuilt.

This should cause old x86 build with csum enabled to fallback to TCP
while interoperating with new ones, which is ugly and bad, but - given
that csum is disable by default - possibly still acceptable?!? 

Thanks!

Paolo 
---
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ac3b7b8a02f6..5b5849d9fe60 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -107,7 +107,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 		}
 		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
-			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+			mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
@@ -221,7 +221,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
 				mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
-				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+				mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
 				ptr += 2;
 			}
 
@@ -1282,7 +1282,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	}
 }
 
-u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
+__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
 	__wsum csum;
@@ -1298,15 +1298,23 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 	header.csum = 0;
 
 	csum = csum_partial(&header, sizeof(header), sum);
-	return (__force u16)csum_fold(csum);
+	return csum_fold(csum);
 }
 
-static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
+static __sum16 mptcp_make_csum(const struct mptcp_ext *mpext)
 {
 	return __mptcp_make_csum(mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 				 ~csum_unfold(mpext->csum));
 }
 
+static void put_len_csum(u16 len, __sum16 csum, __be16 *ptr)
+{
+	put_unaligned_be16(len, ptr);
+
+	ptr += 1;
+	put_unaligned(csum, ptr);
+}
+
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
@@ -1385,9 +1393,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				/* data_len == 0 is reserved for the infinite mapping,
 				 * the checksum will also be set to 0.
 				 */
-				put_unaligned_be32(mpext->data_len << 16 |
-						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
-						   ptr);
+				put_len_csum(mpext->data_len,
+					     mpext->data_len ? mptcp_make_csum(mpext) : 0,
+					     (__force __be16 *)ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
@@ -1438,11 +1446,12 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			goto mp_capable_done;
 
 		if (opts->csum_reqd) {
-			put_unaligned_be32(opts->data_len << 16 |
-					   __mptcp_make_csum(opts->data_seq,
-							     opts->subflow_seq,
-							     opts->data_len,
-							     ~csum_unfold(opts->csum)), ptr);
+			put_len_csum(opts->data_len,
+				     __mptcp_make_csum(opts->data_seq,
+						       opts->subflow_seq,
+						       opts->data_len,
+						       ~csum_unfold(opts->csum)),
+				     (__force __be16 *)ptr);
 		} else {
 			put_unaligned_be32(opts->data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);

