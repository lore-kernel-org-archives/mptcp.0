Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177092;
	b=V0XcResjYeyeTmCBf65FL2+fUSvib/IfXiLlulPw65akfEIUxeQ4Gb+F+vj8S3MXwgSb
	 oaIqsptpCkoO4TZygNjAc4S2BzRUZyjY84BhJvpXjfLjnlY1C3DyuXU0UpVA8UerwbB9Y
	 ZyNnDBrs/kRgXVohMhPwwK73AauxgkH6z/xS/kWCCZ49GApnYYaMBgMJGCrxdDFvRVKnm
	 XZEHHxjccUkHHTWk28z2eEg0VCl0uu1Lp6Mm9znTGyFGpleA/nDPhAlS5waj5EdfwR4v/
	 DwOs01JrQhB60XOetU8XCwvVwneQEdyJtnMMylNWIqRbpGmf5XR94N9gS82niTCxikA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177092;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=YjJw8wdPh4kC1FRbv810ZEoULKssDRVyje8LjZOXafE=;
	b=Slk5qrO1CYdLEghOK1bdT/IzXBmqlM2sDS0EjFUENx1oK46t2vGzZwisyfzjZfc83YbY
	 gHbuVUS0Rq5Jesg7Lp2UMdfcBcpaJVUkn65t+XxmJ8SQqeNT4pIakNWQIW91/lQX02f0S
	 q8imK7tF27D5T4WH/nzOn5hQtpA+QzRG9Fxu3L07IU0fjndXESrLePYgxz7CdT8dFRzW/
	 6oGSlBPhi2NSBPdZyesw+ko+HdCDeoQfTZI9NYKzCh/jK2gMKwZ0r/kF9Rfn6TGYgOVW3
	 g9h+XxWTyt5XpoePZTId+mW29V/Q3MgR8RxmYXr9iQv7Y2IJ/V8XBdHfAlANiAeTi+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ICbNmqex;
	arc=none smtp.remote-ip=203.205.221.155
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3B606A32C;
	Fri, 20 Nov 2026 12:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A3B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ICbNmqex
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795177083; bh=YjJw8wdPh4kC1FRbv810ZEoULKssDRVyje8LjZOXafE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ICbNmqexrCGClx4gUFoZSx79G8KEuflFvTC911PhneU5BqZnlh2R0DUUEtTt23eqg
	 U+5e7gB14LD8xa+pxnM1he7EdUnv6T8mkwX1SHBafjGhnTZWsbRCguCw1KV2z9CEP2
	 Fx+n/ZVwSlh9oeDoGFDMD2hpt/amzofkrQF6BKjA=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:65c9:1ea4:b234:d5d4])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 4809386E; Fri, 20 Nov 2026 20:18:00 +0800
X-QQ-mid: xmsmtpt1795177080t2caxcwhq
Message-ID: <tencent_D8ED43895D9ED0905ABFCAD3F7CA5A2E9009@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0Ck2MAbHYdhvjeLeMcDyAaaLgiFI6Bs6U1CraXb1wCgahYMh9hrl
	 4k+wIx4I/3D+sO6wVoF4snciT8umKUklmk1vzOAfgREATmq4pVr522mBqcB2X6bc5THgPqDRmjfJ
	 e8naRuN2sbUTOTdXC06dlQaEL8g0sDzRyqaAuafK3yP36i6mLnUQxGll92EpOMXw+YdkQ16zkMTQ
	 8qG/mQOwuE2xc+3Y9dUg95vE1/sTw/HCYwgZjesH5bemckrTsTtSuaRgRnTCAiaPYt8iskGSfwg0
	 mLfPy8Oc9g7zzM8cq13LgYQ3VoKb5Cit9ITAhuuH5+n3zQqG8GQxH46L9LdpYnSvUq10QtRu8erq
	 2BeBl1qOwPoQkB12FSxp7/UI4dtvz/nqeLsqIAM2xo3DpEv58BF1dOdpdGztUFwrDZQSGdlZWpyt
	 qPipgttjnxG3SSKV3xxLC1wfscgdioKk+4dSkE8M2OhdFX3hnxAIj3/42ODwwliUrEcQXWFdedBy
	 nSc46svWzp5o2C6ClEEvIuJ5F4fefDXxU94sRM/M6AmjuPh3WBWV9+eUiz2Puol09n3RPO/AnNLc
	 v6kf5HlvghJg5ja1yAMk1g9lut2L44K4MfVTdYdXB3TMBhYjnJ/Wn8TPmOeIkDaa7mdJqP04DYAP
	 MEPDHgEpCuDxj1au0DTONgh6HxO3ptqbFVJg1sjoiEQwME0I4T7DjBJvhZiS5hwvpUQ1S4YQsRfx
	 UFxCB0BoVXCmDOIw34zyqNOvm6Dnmr7R2sfkpSnqfcBC+MMuol4VoBJyoMsQFfxibKoXzNqvL1Ge
	 2/VXOJM4Vn6iKk3WoRxsoNvjTGrHH3ku4M8hxWfIAQEu9I2fdyynZAlcYNmGmlXvS14iYaEeiFfO
	 LW6lDwBNGk+x4xyhl73/h/cslEA4bfiup3EcA175BbRLz3ll+wxBMNMWqVcOruqT3y/FhB8tU22d
	 io2Nu0QPJkYeNB1GGlxAQnSZFnfSs9sbKeHxYK6mwAMUXxhkpoMb6w3kGav2+/uwSBcnc8rEn7de
	 AvkwbjGsUAcOsoQb4ubVVti1szr0KGlp3A7poegQcDVqydAX8kX9L8eK6k4UMBqqH8X9EXyHi40N
	 0TcgCVIGODKcdOdMY=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hang Nan <2122295973@qq.com>
To: lkp@intel.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, 2122295973@qq.com
Subject:
 Re: [PATCH net v5 2/3] net: mptcp: reject token 0 in mptcp_token_get_sock()
Date: Fri, 20 Nov 2026 20:18:00 +0800
X-OQ-MSGID: <179517708044.56979.7846748995584448352@qq.com>
In-Reply-To: <20261116145829.96849-3-2122295973@qq.com>
References: <20261116145829.96849-3-2122295973@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thanks for the report.

The undefined symbol comes from the KUnit case that v5 added for the token 0
guard: it used mptcp_token_exists() to detect whether the socket it had
built was reachable from the bucket it expected, and that function is not
exported, so mptcp_token_test.ko fails at modpost whenever
CONFIG_MPTCP_KUNIT_TEST=m with CONFIG_MPTCP=y.  My local runs had the test
built in, which is why I missed it - sorry about that.

I am dropping the case in the next version rather than exporting the
symbol: a test for a !token guard is not worth either the lines or a new
export, and that also matches the maintainer's comment on the series.
Without the case, the only mptcp token symbols the test file references
are mptcp_token_{get_sock,new_request,new_connect,accept,destroy,
destroy_request}, all of which are EXPORT_SYMBOL_GPL in
net/mptcp/token.c, so that config should link again.

No separate patch is needed for this; it will be fixed in the next
revision, which I will hold until Netdev Sashiko has finished as
requested.

