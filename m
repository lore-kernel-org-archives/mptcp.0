Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E12DE6E6
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467124; cv=none; b=igEmhYfMKFBaPwsTWNwBiXeIIO5mMaL7FBfQztlBrnVS+vkaGOv3S8X+OLIrcRR9HEmzNn1jMeIuV7K6CUTmBUSd2HKiAMl514wc5D5HHPi7dvg1gkcKUm55bWLYLuiQVXPaiPd1rIW6m3Cdl0QZAH8TdNhsad922r1c409ZXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467124; c=relaxed/simple;
	bh=jKrAEgsbqYw7xvDyIRgHG0mkdnYOiumYONM7QglIATo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=qOz1oO31Nz10ZwxTEbUakAvQQi7+dqm6z7rWFtWwPRG/h4l2F/ccnZ+PpGjVApL/n3EZhgmIYy0FLH/jkbk6OfMyaUpHxw6H2czxlHW/t/yyRKacUCMnFS2sC2fI1W05K3zSYRZIoe39OsNB2YAKuvpVWusHNicm3vj9TD2U6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TRDAKYZT; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TRDAKYZT"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=jKrAEgsbqYw7xvDyIRgHG0mkdnYOiumYONM7QglIATo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791467120; v=1; x=1792071920;
 b=TRDAKYZTw87/oSRxSB31blod7Fm8Ln1a8s+CCNTOZ+OS/tfnPBGsCyF2MMskWZOccGOgBMe1
 l70FKSvcskCtBrdUzsC9x6+Q7+/fxG+mN3KbXoJkp4rM082s+C1Jk7wy2JtcaoqJru7FpD+jlrx
 /LRxgIS1gvQEm1T12HmdWkb0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b9c0463afb89fd54;
	Thu, 08 Oct 2026 13:45:20 +0000
X-Mizu-Trace-ID: b9c0463afb89fd54
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 13:45:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: hangbin.liu@linux.dev
Message-ID: <93e09debbb09d20579f3efc127e404dcd775ecee@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next] selftests: mptcp: verify nft JSON support
To: "Matthieu Baerts" <matttbe@kernel.org>, "MPTCP Linux"
 <mptcp@lists.linux.dev>
Cc: "Hangbin Liu" <liuhangbin@kylinos.cn>
In-Reply-To: <00f4f36f-37ce-4845-a86a-ef190961b843@kernel.org>
References: <20261008-mptcp_nft_version-v1-1-efe5f200cb02@kylinos.cn>
 <00f4f36f-37ce-4845-a86a-ef190961b843@kernel.org>

October 8, 2026 at 7:09 PM, "Matthieu Baerts" <matttbe@kernel.org> wrote:
>=20
>=20Hi Hangbin,
>=20
>=20On 08/10/2026 12:00, Hangbin Liu wrote:
>=20
>=20>=20
>=20> Use --version to check for nft presence, as older nft versions reje=
ct -V.
> >  Ensure the nft tool has JSON support, since we need JSON output for
> >  parsing with jq.
> >=20
>=20Thank you for the patch. But do you think it is really needed? 'nft -=
V'
> as been introduced before MPTCP being upstream, and who is building nft
> without JSON support?

Not really, but ...

>=20
>=20As an alternative, I can squash this in "selftests: mptcp: convert
> iptables to nftables for mptcp_sockopt.sh", just to silence Clashiko.

Yes, this is just to silence Clashiko, which report this issue as medium.
Jakub asks to take action for medium+ reports.

And I see you have squashed this. Thanks for your works!

Thanks
Hangbin
