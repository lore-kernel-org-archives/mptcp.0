Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18B2C842
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108641; cv=none; b=cpATBuL5HOrlekwyB6xLfduLHGYU204XHjFw7grzPmWwFeH0T5BPnm3pxxjJes4WPeGNAl1LRzzmw0TAaDiA3UXLAydBJVXiHY6NbaVIWcOjWaoWcNw6mPwwygm4AZzAkELHQuxPLSMallqQxEexFY4lzVT58J8SLrUhg6i1hCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108641; c=relaxed/simple;
	bh=GwO1doUrIe60lbbnA3Z82b/6YBYoUJLVXVMUuNA9P6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7R7k+dhrfgtlCTHWWzrcbpxABh98gz8QZe253KhYJbN0PtAf5HBrV4PndQXklqKT51W2SIwd83ncbYJPmjgSypj4ACRdwXAq/8veD+17XXpIqhaqhkWdYc0xGmqZeA0T6wPkw+xJulo8d60XLx4SM3/zRUZ88T40hVnHStmXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8WSiIdW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8WSiIdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7708BC433C7;
	Wed, 28 Feb 2024 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709108641;
	bh=GwO1doUrIe60lbbnA3Z82b/6YBYoUJLVXVMUuNA9P6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o8WSiIdW7yg+I+7KjejHbZ77g7b368Ixxw8k1ZWAdC/QgQhU7fKCr57ABxxYLRqW0
	 etnNaEmxku4nJAMHYw2jrf8txG1JA5G9qKg1ebqITOZ6aHAM6klaheeO20NtZVXSXT
	 nN3i29XnmLP2TCSfvYHQhKJV0dE3QCjpNvQqI3kn3gwM/Br0qnkOvHHdS4cVBh3M8H
	 jomFir8AV78c4E2UTqukDnVAeeqe+lNxGL8Qg/135jXHhlmvHl8dlY5B2nuvuzsWg8
	 NM90NYRCN/1EGW1C6H6HC8MC8jR7ZRk6flsJ+mPqBizp2OhTjXEFfq8W/LVUc87woM
	 LxrKP5O552k1Q==
Message-ID: <444c3f8a7dfcda7f8f9afdd6d8af09f2e10ff323.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 07/12] selftests: mptcp: print test
 results with counters
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Feb 2024 16:23:55 +0800
In-Reply-To: <e898766d-8116-4d04-9d9f-56245ef0f56d@kernel.org>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
	 <ceb85fa70bc1c314fc7bab4e29b4e1b30e38dae4.1708939962.git.tanggeliang@kylinos.cn>
	 <e898766d-8116-4d04-9d9f-56245ef0f56d@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-02-26 at 13:41 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 26/02/2024 10:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > This patch adds a new helper mptcp_lib_print_test_counter() to
> > print
> > out test counter in each test result and increase the counter. Use
> > this helper to print out test counters for every tests in diag.sh,
> > mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
> > and userspace_pm.sh.
> >=20
> > Each output looks like:
> >=20
> > diag.sh
> > =C2=A001 no msk on netns creation=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0 OK=C2=A0 ]
> > =C2=A002 listen match for dport 10000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [=C2=A0 OK=C2=A0 ]
> > =C2=A003 listen match for sport 10000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [=C2=A0 OK=C2=A0 ]
> > =C2=A004 listen match for saddr and sport=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=
=C2=A0 OK=C2=A0 ]
> > =C2=A005 all listen sockets=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=C2=
=A0 OK=C2=A0 ]
> >=20
> > mptcp_connect.sh
> > =C2=A001 New MPTCP socket can be blocked via sysctl=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > [ OK ]
> > =C2=A0INFO: validating network environment with pings
> > =C2=A002 ping tests=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > [ OK ]
> > =C2=A0INFO: Using loss of 0.16% delay 25 ms reorder .. with delay 6ms o=
n
> > ns3eth4
> > =C2=A003 ns1 MPTCP -> ns1 (10.0.1.1:10000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ) MPTCP=C2=A0 (duration 116ms)
> > [ OK ]
> > =C2=A004 ns1 MPTCP -> ns1 (10.0.1.1:10001=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ) TCP=C2=A0=C2=A0=C2=A0 (duration=C2=A0 33ms)
> > [ OK ]
> > =C2=A005 ns1 TCP=C2=A0=C2=A0 -> ns1 (10.0.1.1:10002=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ) MPTCP=C2=A0 (duration=C2=A0 25ms)
> > [ OK ]
> > =C2=A006 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP=C2=A0 (duration =
128ms)
> > [ OK ]
> > =C2=A007 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP=C2=A0=C2=A0=C2=A0 =
(duration=C2=A0 31ms)
> > [ OK ]
> >=20
> > mptcp_sockopt.sh
> > =C2=A001 transfer ipv4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [
> > OK ]
> > =C2=A002 mark ipv4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> > =C2=A003 transfer ipv6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [
> > OK ]
> > =C2=A004 mark ipv6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> > =C2=A0PASS: all packets had packet mark set
> > =C2=A005 sockopt v4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> > =C2=A006 sockopt v6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> > =C2=A0PASS: SOL_MPTCP getsockopt has expected information
> > =C2=A007 TCP_INQ: -t tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [
> > OK ]
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -t tcp
> > =C2=A008 TCP_INQ: -6 -t tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> > =C2=A009 TCP_INQ: -r tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [
> > OK ]
> > =C2=A0PASS: TCP_INQ cmsg/ioctl -r tcp
> > =C2=A010 TCP_INQ: -6 -r tcp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> >=20
> > pm_netlink.sh
> > =C2=A001 defaults addr list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A002 simple add/get addr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A003 dump addrs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A004 simple del addr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A005 dump addrs after del=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [ OK ]
> > =C2=A006 duplicate addr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A007 id addr increment=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A008 hard addr limit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK ]
> > =C2=A009 above hard addr limit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [ OK ]
> >=20
> > simult_flows.sh
> > =C2=A001 balanced bwidth=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7411 max 8456=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [
> > OK ]
> > =C2=A002 balanced bwidth - reverse direction=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 7380 max 8456=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> > =C2=A003 balanced bwidth with unbalanced delay=C2=A0=C2=A0=C2=A0 7434 m=
ax 8456=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [
> > OK ]
> >=20
> > userspace_pm.sh
> > =C2=A0INFO: Init
> > =C2=A001 Created network namespaces ns1, ns2=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK
> > ]
> > =C2=A0INFO: Make connections
> > =C2=A002 Established IPv4 MPTCP Connection ns2 =3D> ns1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK
> > ]
> > =C2=A003 Established IPv6 MPTCP Connection ns2 =3D> ns1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK
> > ]
> > =C2=A0INFO: Announce tests
> > =C2=A004 ADD_ADDR 10.0.2.2 (ns2) =3D> ns1, invalid token=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK
> > ]
> > =C2=A005 ADD_ADDR id:14 10.0.2.2 (ns2) =3D> ns1, reuse port=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ OK
> > ]
> >=20
> > Having test counters helps to quickly identify issues when looking
> > at a
> > long list of output logs and results.
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0tools/testing/selftests/net/mptcp/diag.sh=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 8 ++---
> > =C2=A0.../selftests/net/mptcp/mptcp_connect.sh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 33 +++++++++++----
> > ----
> > =C2=A0.../testing/selftests/net/mptcp/mptcp_lib.sh=C2=A0 |=C2=A0 8 ++++=
+
> > =C2=A0.../selftests/net/mptcp/mptcp_sockopt.sh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 ++++---
> > =C2=A0.../testing/selftests/net/mptcp/pm_netlink.sh |=C2=A0 6 ++--
> > =C2=A0.../selftests/net/mptcp/simult_flows.sh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 7 ++--
> > =C2=A0.../selftests/net/mptcp/userspace_pm.sh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 3 +-
> > =C2=A07 files changed, 47 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/diag.sh
> > b/tools/testing/selftests/net/mptcp/diag.sh
> > index f9f62a8f41e3..01e9f11f1f47 100755
> > --- a/tools/testing/selftests/net/mptcp/diag.sh
> > +++ b/tools/testing/selftests/net/mptcp/diag.sh
> > @@ -9,7 +9,7 @@
> > =C2=A0. "$(dirname "${0}")/mptcp_lib.sh"
> > =C2=A0
> > =C2=A0ns=3D""
> > -test_cnt=3D1
> > +test_cnt=3D0
>=20
> Is it normal shellcheck doesn't complain about it not being used?

test_cnt still be used in this script in another place:

	ret=3D$test_cnt

>=20
> > =C2=A0timeout_poll=3D30
> > =C2=A0timeout_test=3D$((timeout_poll * 2 + 1))
> > =C2=A0ret=3D0
> > @@ -55,7 +55,7 @@ __chk_nr()
> > =C2=A0
> > =C2=A0	nr=3D$(eval $command)
> > =C2=A0
> > -	printf "%-50s" "$msg"
> > +	mptcp_lib_print_test_counter test_cnt "%-50s" "$msg"
>=20
> Same here, probably best with a helper, to avoid repeating the long
> list
> of arguments:
>=20
> =C2=A0 # $1: test name
> =C2=A0 print_test() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_lib_print_test_counter test_cnt "%-5=
0s" "${1}"
> =C2=A0 }
>=20
> =C2=A0 (...)
>=20
> =C2=A0 print_test "${msg}"


print_title is added here.

>=20
> Same in the other files not using a helper already (like
> mptcp_join.sh
> and userspace_pm.sh)
>=20
> (see my comment in mptcp_lib.sh: maybe easier to remove params, and
> just
> call 'mptcp_lib_print_test_counter "${msg}"')
>=20
> > =C2=A0	if [ "$nr" !=3D "$expected" ]; then
> > =C2=A0		if [ "$nr" =3D "$skip" ] && !
> > mptcp_lib_expect_all_features; then
> > =C2=A0			mptcp_lib_print_warn "[SKIP] Feature
> > probably not supported"
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 06e945914ace..00bbe451e50d 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -131,6 +131,7 @@ ns2=3D""
> > =C2=A0ns3=3D""
> > =C2=A0ns4=3D""
> > =C2=A0
> > +#shellcheck disable=3DSC2034
>=20
> Please justify all disabled shellcheck checks, e.g.
>=20
> #shellcheck disable=3DSC2034 # TEST_COUNT is used by mptcp_lib.sh

Updated.

>=20
> same below
>=20
> (see my comment below: why not defining it in mptcp_lib.sh then?)
>=20
> > =C2=A0TEST_COUNT=3D0
> > =C2=A0TEST_GROUP=3D""
> > =C2=A0
> > @@ -255,8 +256,9 @@ check_mptcp_disabled()
> > =C2=A0
> > =C2=A0	# net.mptcp.enabled should be enabled by default
> > =C2=A0	if [ "$(ip netns exec ${disabled_ns} sysctl
> > net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
> > -		echo -n -e "net.mptcp.enabled sysctl is not 1 by
> > default"
> > -		mptcp_lib_print_err "\t\t\t=C2=A0=C2=A0 [FAIL]"
> > +		mptcp_lib_print_test_counter TEST_COUNT "%s" \
> > +			"net.mptcp.enabled sysctl is not 1 by
> > default"
>=20
> The test name should be printed before the test: so the counter will
> be
> incremented in case of issue or not:
>=20
> =C2=A0 mptcp_lib_print_test_counter "MPTCP socket can be blocked via
> sysctl"
> =C2=A0 if [ ... ]; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_lib_print_fail "net.mptcp.enab=
led sysctl is not (...)"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (...)
> =C2=A0 fi
>=20
> =C2=A0 if [ ... ]; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_lib_print_fail "MPTCP socket c=
annot be blocked via
> sysctl"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (...)
> =C2=A0 fi
>=20
> =C2=A0 mptcp_lib_print_success

Updated.

>=20
>=20
> > +		mptcp_lib_print_err "\t\t\t\t=C2=A0=C2=A0 [FAIL]"
> > =C2=A0		mptcp_lib_result_fail "net.mptcp.enabled sysctl is
> > not 1 by default"
> > =C2=A0		ret=3D1
> > =C2=A0		return 1
> > @@ -269,15 +271,17 @@ check_mptcp_disabled()
> > =C2=A0	mptcp_lib_ns_exit "${disabled_ns}"
> > =C2=A0
> > =C2=A0	if [ ${err} -eq 0 ]; then
> > -		echo -n -e "New MPTCP socket cannot be blocked via
> > sysctl"
> > -		mptcp_lib_print_err "\t\t\t=C2=A0=C2=A0 [FAIL]"
> > +		mptcp_lib_print_test_counter TEST_COUNT "%s" \
> > +			"New MPTCP socket cannot be blocked via
> > sysctl"
> > +		mptcp_lib_print_err "\t\t\t\t=C2=A0=C2=A0 [FAIL]"
> > =C2=A0		mptcp_lib_result_fail "New MPTCP socket cannot be
> > blocked via sysctl"
> > =C2=A0		ret=3D1
> > =C2=A0		return 1
> > =C2=A0	fi
> > =C2=A0
> > -	echo -n -e "New MPTCP socket can be blocked via sysctl"
> > -	mptcp_lib_print_ok "\t\t\t=C2=A0=C2=A0 [ OK ]"
> > +	mptcp_lib_print_test_counter TEST_COUNT "%s" \
> > +		"New MPTCP socket can be blocked via sysctl"
> > +	mptcp_lib_print_ok "\t\t\t\t=C2=A0=C2=A0 [ OK ]"
> > =C2=A0	mptcp_lib_result_pass "New MPTCP socket can be blocked via
> > sysctl"
> > =C2=A0	return 0
> > =C2=A0}
> > @@ -319,7 +323,6 @@ do_transfer()
> > =C2=A0
> > =C2=A0	local port
> > =C2=A0	port=3D$((10000+PORT++))
> > -	TEST_COUNT=3D$((TEST_COUNT+1))
> > =C2=A0
> > =C2=A0	if [ "$rcvbuf" -gt 0 ]; then
> > =C2=A0		extra_args=3D"$extra_args -R $rcvbuf"
> > @@ -346,7 +349,7 @@ do_transfer()
> > =C2=A0	addr_port=3D$(printf "%s:%d" ${connect_addr} ${port})
> > =C2=A0	local result_msg
> > =C2=A0	result_msg=3D"$(printf "%.3s %-5s -> %.3s (%-20s) %-5s"
> > ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port}
> > ${srv_proto})"
> > -	printf "%s\t" "${result_msg}"
> > +	mptcp_lib_print_test_counter TEST_COUNT "%s\t"
> > "${result_msg}"
> > =C2=A0
> > =C2=A0	if $capture; then
> > =C2=A0		local capuser
> > @@ -663,7 +666,8 @@ run_test_transparent()
> > =C2=A0	# following function has been exported (T). Not great but
> > better than
> > =C2=A0	# checking for a specific kernel version.
> > =C2=A0	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
> > -		echo "INFO: ${msg} not supported by the kernel:
> > SKIP"
> > +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> > +			"INFO: ${msg} not supported by the kernel:
> > SKIP"
>=20
> Same here, the test name and counter should be handled before the
> 'if',
> not just for the SKIP if possible.

Updated.

>=20
> > =C2=A0		mptcp_lib_result_skip "${TEST_GROUP}"
> > =C2=A0		return
> > =C2=A0	fi
> > @@ -680,7 +684,8 @@ table inet mangle {
> > =C2=A0}
> > =C2=A0EOF
> > =C2=A0	then
> > -		echo "SKIP: $msg, could not load nft ruleset"
> > +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> > +			"SKIP: $msg, could not load nft ruleset"
>=20
> Same here, the test name and counter should be handled before the
> 'if',
> not just for the SKIP if possible.

Updated.

>=20
> > =C2=A0		mptcp_lib_fail_if_expected_feature "nft rules"
> > =C2=A0		mptcp_lib_result_skip "${TEST_GROUP}"
> > =C2=A0		return
> > @@ -696,7 +701,8 @@ EOF
> > =C2=A0
> > =C2=A0	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1
> > lookup 100; then
> > =C2=A0		ip netns exec "$listener_ns" nft flush ruleset
> > -		echo "SKIP: $msg, ip $r6flag rule failed"
> > +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> > +			"SKIP: $msg, ip $r6flag rule failed"
>=20
> Same here, the test name and counter should be handled before the
> 'if',
> not just for the SKIP if possible.

Updated.

>=20
> > =C2=A0		mptcp_lib_fail_if_expected_feature "ip rule"
> > =C2=A0		mptcp_lib_result_skip "${TEST_GROUP}"
> > =C2=A0		return
> > @@ -705,7 +711,8 @@ EOF
> > =C2=A0	if ! ip -net "$listener_ns" route add local $local_addr/0
> > dev lo table 100; then
> > =C2=A0		ip netns exec "$listener_ns" nft flush ruleset
> > =C2=A0		ip -net "$listener_ns" $r6flag rule del fwmark 1
> > lookup 100
> > -		echo "SKIP: $msg, ip route add local $local_addr
> > failed"
> > +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> > +			"SKIP: $msg, ip route add local
> > $local_addr failed"
>=20
> Same here, the test name and counter should be handled before the
> 'if',
> not just for the SKIP if possible.

Updated.

>=20
> > =C2=A0		mptcp_lib_fail_if_expected_feature "ip route"
> > =C2=A0		mptcp_lib_result_skip "${TEST_GROUP}"
> > =C2=A0		return
> > @@ -861,7 +868,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
> > =C2=A0
> > =C2=A0stop_if_error "Could not even run ping tests"
> > =C2=A0
> > -echo -e "ping tests"
> > +mptcp_lib_print_test_counter TEST_COUNT "%s" "ping tests"
> > =C2=A0mptcp_lib_print_ok "\t\t\t\t\t\t\t\t=C2=A0=C2=A0 [ OK ]"
> > =C2=A0
> > =C2=A0[ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root
> > netem loss random $tc_loss delay ${tc_delay}ms
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > index 7e309493eda2..df495658f043 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > @@ -411,3 +411,11 @@ mptcp_lib_events() {
> > =C2=A0	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1
> > &
> > =C2=A0	pid=3D$!
> > =C2=A0}
> > +
> > +mptcp_lib_print_test_counter() {
>=20
> Maybe more "mptcp_lib_print_test_title" or "_name": it doesn't just
> print the counter, mostly the "title" (including the counter, part of
> the title)

Rename to mptcp_lib_print_title.

>=20
> > +	declare -n counter=3D"${1}"
> > +	local fmt=3D"${2}"
> > +	local msg=3D"${3}"
> > +
> > +	printf "%02u ${fmt}" "$((++counter))" "${msg}"
>=20
> Maybe having this:
>=20
> =C2=A0 : "${MPTCP_LIB_PRINT_TEST_FORMAT:=3D"%02u %-50s"}"
> =C2=A0 MPTCP_LIB_TEST_COUNTER=3D0
>=20
> =C2=A0 (...)
>=20
> =C2=A0 # $1: test name
> =C2=A0 mptcp_lib_print_test_counter() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf "${MPTCP_LIB_PRINT_TEST_FORMAT}" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"$((++MPTCP_LIB_TEST_COUNTER))" "${1}"
> =C2=A0 }
>=20
> Would simplify stuff?

Do you mean to define TEST_COUNT in mptcp_lib.sh? That means we need to
rename test_cnt to TEST_COUNT. I remember you objected to move vars
into mptcp_lib.sh like in "selftests: mptcp: add mptcp_lib_ns_init/exit
helpers". So I pass TEST_COUNT or test_cnt as an argument to
mptcp_lib_print_test_counter().

I think this can keep continuity with other functions in mptcp_lib,
like mptcp_lib_ns_init/exit.

>=20
> So tests can specify the format by setting
> MPTCP_LIB_PRINT_TEST_FORMAT,
> e.g. to support more than 99 entries. And you don't need to define
> TEST_COUNT and disable SC2034.
>=20
> Would that work?
>=20
> You could even use it in mptcp_join.sh: print_title() would call this
> new helper.
>=20
> > +}
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > index cfa0cfb918f4..a2a5049f22bb 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> > @@ -17,6 +17,8 @@ timeout_poll=3D30
> > =C2=A0timeout_test=3D$((timeout_poll * 2 + 1))
> > =C2=A0iptables=3D"iptables"
> > =C2=A0ip6tables=3D"ip6tables"
> > +#shellcheck disable=3DSC2034
> > +test_cnt=3D0
> > =C2=A0
> > =C2=A0ns1=3D""
> > =C2=A0ns2=3D""
> > @@ -161,7 +163,7 @@ do_transfer()
> > =C2=A0	wait $spid
> > =C2=A0	local rets=3D$?
> > =C2=A0
> > -	printf "%-50s" "transfer ${ip}"
> > +	mptcp_lib_print_test_counter test_cnt "%-50s" "transfer
> > ${ip}"
>=20
> Same my comments on previous patches: if here a helper is used to
> print
> the test name, you would only need to change this helper, not doing
> the
> same modification multiple times at the same places.

Do this in print_title helper.

>=20
> > =C2=A0	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
> > =C2=A0		echo " client exit code $retc, server $rets" 1>&2
> > =C2=A0		echo -e "\nnetns ${listener_ns} socket stat for
> > ${port}:" 1>&2
>=20
> (...)
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> > b/tools/testing/selftests/net/mptcp/simult_flows.sh
> > index 79cb377ee0bd..eb2eaa48035f 100755
> > --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> > +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> > @@ -14,7 +14,7 @@ ns3=3D""
> > =C2=A0capture=3Dfalse
> > =C2=A0timeout_poll=3D30
> > =C2=A0timeout_test=3D$((timeout_poll * 2 + 1))
> > -test_cnt=3D1
> > +test_cnt=3D0
>=20
> Why ShellCheck is not complaining the variable is not used here?

test_cnt still be used in this script.

>=20
> > =C2=A0ret=3D0
> > =C2=A0bail=3D0
> > =C2=A0slack=3D50
>=20
> (...)
>=20
> While at it, can you make sure all the results are aligned for
> simult_flows by increasing the '%-XXs'?
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > index 33bbb0d5807f..27f308601005 100755
> > --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > @@ -53,6 +53,7 @@ server_addr_id=3D${RANDOM:0:2}
> > =C2=A0ns1=3D""
> > =C2=A0ns2=3D""
> > =C2=A0ret=3D0
>=20
> Why ShellCheck is not complaining the variable is not used here?

The same.

>=20
> > +test_cnt=3D0
> > =C2=A0test_name=3D""
> > =C2=A0
> > =C2=A0_printf() {
>=20
> (...)
>=20
> Cheers,
> Matt

