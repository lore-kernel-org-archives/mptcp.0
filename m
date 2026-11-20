Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190278;
	b=m155ekWZha+lInDlsOftdBxDls5me3/9vKpwTNv/FZfHpsRry2ObDnxutIVNyHxgABFv
	 98Z78Vl+Vt+iCOONQm3ZzENRl0y8u61kWjUflvC8SSyHH6Ds/y/a7qa/ImfzxG+rdF4vT
	 njpJuRLfcI/fRLMSAf81WUM+YkpzHc7coY5qZ8USEJsbnQHzYj6M/jJDDpOYjQEE+eh0a
	 GmXzmYOxZJNKyns1usZsFe9Zj3X7wwJi3UOmLYuxKgQbBN6I6TSmsBE7jbWdhmYUh7ws7
	 UKBM5HCG8sqLXNo52EfTRwnYP65ksq+4JvDCRNqF2ZxG/HkJurtkTVqT7OlLg1cgqKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pm8u00luEHPD8UqotMjG070Q5sXmI3sUREQgOaFHhqs=;
	b=eAXe5CvPDmi2B11xt+2a4ypDcXIKCeClQIagROKOv7f359zsqDMq47T3DwMuXw6Agdzl
	 eScKBS7HpNawgxCoVgvVuUyYo/pEcZpw8yghQopW/CjYUTQZNY4r7/uzkgmTKHYMiAtz2
	 k0VclXWfQuofz6RksAIvXgctZ1fnScxvkyWKK9tqBY4VveqkZnTklS7cFosIw174iTRPb
	 cO5yya4inN5dMoJCMktN0y66QGmrVgTdVRoJovJcvnJ2VuQo7rybijAUVkUFE+zEHm/pW
	 uTDY/L+hJ67sbjH7/OO4/35CAitFYYUtoUiVdgcjw07qzmb5oJ/nRmLFntZSXzY5KGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDyBHK8D;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99D606A32C
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 15:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A99D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDyBHK8D
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so2778590eec.0
        for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190277; x=1795795077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pm8u00luEHPD8UqotMjG070Q5sXmI3sUREQgOaFHhqs=;
        b=EDyBHK8DkfSCb/+ZShiPOe4laVgpdlEA7ahElt8UkYPbzqVEI/zxwdCwKjwT2+sRJF
         ZupXrKnLYtrKbCSzp0o/NTVQE/ckGfFGPgxDEB1v0W5L+H7Rtl0Jvkoaiua3JplvskOJ
         sAGGSCbi9P+J8X7TUMz+Bk8D7SMMUTLznUobbBtUJ6lVosUZnojnRjRXCLRLej9/n9L7
         0xgGUgIVmWsQ361Sf15CPdBm6oRs5zIILGWuu+hJHEjYr6attwqVY7bYlodH0gsLlFyX
         jJ07SEZ8gz6ZYMGDUPhyqTvAwGOChHPH0w4kdvpaQTsUNTAedvTUe+piUJnZn6elnnjX
         ImEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190277; x=1795795077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pm8u00luEHPD8UqotMjG070Q5sXmI3sUREQgOaFHhqs=;
        b=ynB2yDvHp6W/PcDSZQYd3v3Jhyiu0q3D3wMnkSRKTzwWmSQ/Cy4RSEV34vu4SmX6pd
         IXFlRJ/M6pFn8dH8fsJ3gpR+26wbc6yqeWd3BYo4nyb3cd8iyBtbo3IYGojCm+n6WDxM
         z//STM0xwjItpYfZ2Jl0JkCGraQeAYKiUOnggThwQu4aiqUunfiNphjg044XRwcuNywH
         HU0LVHEHEnIaipOBh2Wtx575CJf2+ds6bMkuPQktSkvCKh/gxVJr1Ledw49Q2fo5H4Oi
         WPGztQBXzUjrSQq7KAS6n9s47zsocLYquIQ3oKUm1G/X6EppFoYYMPg3LfvAmtRd0eSR
         DEwQ==
X-Gm-Message-State: APuU4Z/kAZJ78HGZiuI/s7qP9zqkHQ358AlShDFHEqusQgPYjT137M/p
	2yQWSahUKBR6ESc4uRnEQKE7S+7aWDgchKQ19q/C/rLSNXVxGU44zwie9JhITA==
X-Gm-Gg: AZFdTZd3BqRF5go8urWa2kzwluvoAMdkwTT8/YKjf7QX6ajKmVgT35LhLnMRBQXzOQ6
	JjirSs4f3Sg3Etp0xuF/z3ZZTiMON9ypwMSWjMRbYeK5rca4a+sPONTZZbEkXA/tT5MoqJ7bAjW
	L3E1Rn2BnIGNtTdCFz0x/hlFa3o1/Vb9B0H62cXRzknj6dK6i/XD66TNK42I/+gc0OcjRrDgB1i
	zRvvXgTmoBAe2hP3XODok59lsaxNhMk7vMK501hB34J3h7Ww/VB9ak/ZT9xffZ/jhu2oi/3gwBi
	qmPPzv5R93Ck/Wgn93GMpmrrswbJIPQjdLmHh0J6T5oPa07yYbiEJLp5CLcMNRS7M+ZsnErSKiF
	HxNJ9xkj0VqOKXPvAB10PGi+l8m3geZsueo1pPcC9eRDx2MvdOW3veedgN2nmQlS75mzo/ZrqUZ
	g5cQcGQlZCKlx5l8hkvAScYf/Ge7YhQPZMCN302m2DjHYsigi6nUSxpl2FbgqZcTpGElDHgS4I1
	0jVntPG7ARgwJ/Hu7Umc9sO8NtCH8Z8KpA28nxhhhRDWtZ/SLI6UHROoFVOC9PSXEuAsoohaQVP
	Wx7rkFPw0L28254JhJMl2nnmY5K8wXVnYj1OfLQEIBfuu7cz45llzpwy05m5+2oltwaJZ1myjqb
	Nni/vT5jqCIx4O1vFUczZdAhWsSzGSFQGSpKaheHdRAIBvtIHgd7pDpv05vPHtSj1eym9IzwtJw
	8=
X-Received: by 2002:a05:7300:8288:b0:384:f214:a408 with SMTP id 5a478bee46e88-3857044f2ffmr3489903eec.38.1795190276932;
        Fri, 20 Nov 2026 07:57:56 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm8866592eec.7.2026.11.20.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:57:56 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-mptcp v2 2/3] mptcp: limits: add subflow_retries
Date: Fri, 20 Nov 2026 15:57:48 +0000
Message-Id: <20261120155749.2126268-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261120155749.2126268-1-anilkaushikwireless@gmail.com>
References: <20261120155749.2126268-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The in-kernel path manager can re-create a subflow closed after a
retransmission or keepalive timeout. The new subflow-retries limit sets
the number of SYN retries of such subflow, like the TCP_SYNCNT socket
option: 127 by default, also the maximum, and 0 to not re-create it.

Add it to "ip mptcp limits set" and show it in "ip mptcp limits show"
when the kernel reports it:

  # ip mptcp limits set subflow_retries 5
  # ip mptcp limits show
  add_addr_accepted 0 subflows 2 subflow_retries 5

The new keyword is matched exactly, so "subflow" still means "subflows".

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 ip/ipmptcp.c        | 21 ++++++++++++++++++++-
 man/man8/ip-mptcp.8 | 10 ++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 54976c08..3dc3ee40 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -30,6 +30,7 @@ static void usage(void)
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
+		"			    [ subflow_retries NR ]\n"
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
@@ -362,9 +363,11 @@ static int mptcp_addr_flush(int argc, char **argv)
 static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
 {
 	bool set_rcv_add_addrs = false;
+	bool set_retries = false;
 	bool set_subflows = false;
 	__u32 rcv_add_addrs = 0;
 	__u32 subflows = 0;
+	__u32 retries = 0;
 
 	while (argc > 0) {
 		if (matches(*argv, "subflows") == 0) {
@@ -379,6 +382,12 @@ static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
 			if (get_u32(&rcv_add_addrs, *argv, 0))
 				invarg("invalid add_addr_accepted\n", *argv);
 			set_rcv_add_addrs = true;
+		} else if (strcmp(*argv, "subflow_retries") == 0) {
+			NEXT_ARG();
+
+			if (get_u32(&retries, *argv, 0))
+				invarg("invalid subflow_retries\n", *argv);
+			set_retries = true;
 		} else {
 			invarg("unknown limit", *argv);
 		}
@@ -390,7 +399,10 @@ static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
 			  rcv_add_addrs);
 	if (set_subflows)
 		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_SUBFLOWS, subflows);
-	return set_rcv_add_addrs || set_subflows;
+	if (set_retries)
+		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			  retries);
+	return set_rcv_add_addrs || set_subflows || set_retries;
 }
 
 static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
@@ -424,6 +436,13 @@ static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
 		print_uint(PRINT_ANY, "subflows", "subflows %d ", val);
 	}
 
+	if (tb[MPTCP_PM_ATTR_SUBFLOW_RETRIES]) {
+		val = rta_getattr_u32(tb[MPTCP_PM_ATTR_SUBFLOW_RETRIES]);
+
+		print_uint(PRINT_ANY, "subflow_retries", "subflow_retries %d ",
+			   val);
+	}
+
 	print_nl();
 	close_json_object();
 
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index c03935dd..e38eb05f 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -92,6 +92,9 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "[ "
 .B add_addr_accepted
 .IR  ADD_ADDR_ACCEPTED_NR " ]"
+.RB "[ "
+.B subflow_retries
+.IR SUBFLOW_RETRIES_NR " ]"
 
 .ti -8
 .BR "ip mptcp limits show"
@@ -268,6 +271,13 @@ In both cases the
 .IR SUBFLOW_NR
 limit is enforced.
 
+.TP
+.IR SUBFLOW_RETRIES_NR
+specifies the number of SYN retries used when the in-kernel path manager
+re-creates a subflow closed after a retransmission or keepalive timeout,
+like the TCP_SYNCNT socket option. The default and maximum value is 127,
+about 4 hours with the default RTO settings. 0 disables the re-creation.
+
 .sp
 .PP
 .B monitor
-- 
2.25.1

