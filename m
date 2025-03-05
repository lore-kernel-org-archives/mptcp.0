Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194C2475F7
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180412; cv=none; b=WegvX1bHYy1avQkFIok3dEPiAlIoTaGfDZhQ55xBVTjOUnVl9gDzM2PRvbWeqRPxq3SsaAnvHYCjsCrtsyCAvP8MoPgXfC4evyCdhgPWFs9cK8OrocI5d1WJGy/Ke2UWp/sXBB10zH4wE2lBgGL8U3JF7w0LdNlqRRs1S2xuJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180412; c=relaxed/simple;
	bh=Db+3IGZoI/zX0bgg9Q+/RNYwmAKroRmVTwL767Q1YLk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bEZdR10CK/sZO+oHXjDsBpzPiLKMfBE135UOd0EeTPgYekbL/Vb3kwePSM7Os1jUxkvLdXfGjxLzW8nOQZsIZ4DK82X1VtE64GRfumjl0drLUpKbL7y/hVqYLVi9pqAsyZxTeflHM9uUMtEkKIiDYcsjyCFk8ixU2mHixjp0mVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Ga8nlG2F; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Ga8nlG2F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:To:From:Date:CC;
	bh=Db+3IGZoI/zX0bgg9Q+/RNYwmAKroRmVTwL767Q1YLk=; b=Ga8nlG2FmmEOhynkGeIAx7b2cz
	dXqgQLpmSvNDOsj92GbRr3+ut7UXOxfGtERdX7iHjLqN1HvKTEH03adPgRtW5xP4cjn4uW8hAV08K
	h/eplTC6rDZKNLTdiJveB7lls7uRc8782vjbeBkyVEgVY/2VTsYfDq+k2jTus6i81mFHrGhYtd6R/
	85nkCPHByV9oflkvyiIzbqIXY7I+1BkAfeYrcqyzVrayrGrhpm6U4PStb5D1snZq9AMXC0RT59/cU
	RLHcPhw9+olumInJG6uVBmnYJJLuZAA5rpGJhJCDl+8R4DsuWzGUU4yBidn7E9sSdhSKc5uU+sIj/
	qzEBRNdfRT02ZlsZOxunU87J+oqpmTAZ0g+kskhcFkuRzPl8Ndlo4SpON7zVYQOmP5gaCkT9CJNPe
	6kUyQlcbM9ws8ckWLIIyrhjSU6op3Hyw68xgstnpe+XPXLV0WPb3JzBJwCajI8PhPhXLqLy7Qspc3
	829KaiPmriZIEYKXLR7Qpjkt;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1tpoYr-003W13-10
	for mptcp@lists.linux.dev;
	Wed, 05 Mar 2025 13:13:21 +0000
Received: from bjacke by pell.int.sernet.de with local (Exim 4.93)
	(envelope-from <bjacke@sernet.de>)
	id 1tpoYq-00BEZI-JD
	for mptcp@lists.linux.dev; Wed, 05 Mar 2025 14:13:20 +0100
Date: Wed, 5 Mar 2025 14:13:20 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= JACKE <bjacke@samba.org>
To: mptcp@lists.linux.dev
Subject: mtpcp not usable with ipv6 if built as module
Message-ID: <20250305131320.GA2676143@sernet.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Q: Die Schriftsteller koennen nicht so schnell schreiben, wie die
 Regierungen Kriege machen; denn das Schreiben verlangt Denkarbeit. - Brecht

Hi,

I know that this is a known issue and https://www.mptcp.dev/setup.html mentions
this but I would like to encourage the developers to fix the problem that mptcp
for ipv6 isn't available if ipv6 is built as a module.

The problem that mptcp doesn't work with ipv6 if built as a module is also not
very obvious when you are working on such a system. It simply does not work,
but no dmesg message or so is mentioning the lack of mptcp support at runtime.

The system where I hit this was as raspi system, where ipv6 is built as a
module due to size reasons, which is reasonable for small memory systems. See
https://github.com/raspberrypi/linux/issues/6518 and
https://github.com/raspberrypi/linux/pull/5487

Maybe this is a bit of a motivation to fix the module build of mptcp with ipv6,
raspberry users (and some more probably) would very much apreciate it.

Cheers
Björn

