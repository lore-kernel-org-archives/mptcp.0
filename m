Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815E433BD2;
	Mon, 13 Jul 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950604; cv=none; b=F4Ehdl5bwaX3aogYFpJ4+AjoRkIBOj7cjrwiW+KthcmmO/4wvEnG3jUpnJ4JGrZZWzVcy8bSnT0C5NdxG77zyH1JxE8tM1OrxV0T9AkES227k6zGHUj2AdIZLcWITDni8SyJmJDscjjwxWpClMJDKOI6liJACvHTfwdJ3AHZrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950604; c=relaxed/simple;
	bh=gvFBCp6oCXgGaGuHcNpfnQGVuqtKvCrdVu/GHrCmwdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ+tnQXKpxJJPworf1fIM9/nEfFt4y5KEmLxn6ztIhr8QlGBG5dqGwWiTzygACIIfTjhxfcuri89Q17fbFSSnDbNfdZlG+1uGcxyzeHpKb+UgyXYcETa7c3oxBdKIUr4Xuj5ntU7FYVc+wTxX5ujmcyMTfYBY+V8t++at7sdAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjH2l-00000001XIV-39vz;
	Mon, 13 Jul 2026 15:49:59 +0200
Date: Mon, 13 Jul 2026 15:49:59 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <alTtBzvuUbmyMMfP@eidolon.nox.tf>
References: <20260713080634.296011-1-equinox@diac24.net>
 <202607132109.n8GCw6cD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607132109.n8GCw6cD-lkp@intel.com>

On Mon, Jul 13, 2026 at 09:24:52PM +0800, kernel test robot wrote:
>    sparc-linux-ld: net/mptcp/sockopt.o: in function `mptcp_setsockopt_v6':
> >> sockopt.c:(.text+0x908): undefined reference to `ipv6_setsockopt'

Oops.  Forgot IPv6 can still be disabled.  v2 in a few minutes.
