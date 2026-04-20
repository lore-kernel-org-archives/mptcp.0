Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154D393DFD
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680132; cv=none; b=n4t2/5nl6X07xckhQHfkkeGmrbMDdGRMuBb5WcGXsrv9TpR8I0MxcQiEX1n7jfnRK9rg4PeZf2oqWh3lDb4uW3mC7gOF5tbdcbh6uFPEBTzGT8+/y2XlRK+LReGo6IJZzGj2cbBi2bLoW5m4SXrDm4VB0bqbECSjzi+LqeJMfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680132; c=relaxed/simple;
	bh=jeZ6axS0z+/u5zLEoBy/iMBKukSdV5khZ3tDuN19gGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drRXjXu5aKwRLTiE0mNKgCks5R/+R1PII12ew2b7lDgT7SzIr3jE7OZg1FwRNHDDs07+10bAYWNH+I2p0RYWtH4HiqY0SJZfJoD6tvH6FaPDARanzPCG4d4rlSaUyTOu4PGPF2z05qlgjSZn3i2JPXTOZyIJzQs65261L3dbkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EEm6DLuR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiCMKETj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEm6DLuR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiCMKETj"
Date: Mon, 20 Apr 2026 12:15:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776680128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMyjHnGlqdoIum0HdiuinTdbTgMxtUfNvwiiDU48OO0=;
	b=EEm6DLuRefJ64mrmSuMXc+tedtrj2DQ33OxNVygY73lFjDJcCB8p7RHiDRNYyiIvPiQbcG
	5fQ4XKCGNIXClaLJDjKa+YB4Jivuml1R3KjbKAaRn8cKNUbDewx1epBClzJmMd0BjRkq07
	FUMi7v95zATnIAMypJStAMdlWa7TKt8xpenk9UcYtT5NJkavAQ0ccBi51q6AZvxdbyagRP
	WsFYuZ5TqcjajagcIaAA4IvOv8flgkTRteEQ3u16QTszlv++NYiEMjXJAyDso+sbzKcYX9
	PqyyQRqyXk4NLgw24/n+IcBFv2nwYr9v5WCKHs82qai1gbOImqMBkd5UrmHOzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776680128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMyjHnGlqdoIum0HdiuinTdbTgMxtUfNvwiiDU48OO0=;
	b=RiCMKETjVasm1jVUvE9MSxc50IYVJEZc01cS04fuD8prrZ210iVvrGASwtLD7bxy4s6TRx
	+YhjZe3f22XY+UCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v2] selftests: harness: fix pidfd leak in __wait_for_test
Message-ID: <20260420121444-2eb5e0cc-a7fe-4199-9ac2-5bbc9eb421cb@linutronix.de>
References: <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>

On Mon, Apr 20, 2026 at 05:45:28PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Fix the pidfd leak in kselftest_harness.h's __wait_for_test() where
> childfd = syscall(__NR_pidfd_open, t->pid, 0) is never closed.
> 
> Fixes: 73a3cde97677 ("selftests: harness: Implement test timeouts through pidfd")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

(...)
