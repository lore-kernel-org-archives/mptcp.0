Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF761E0E14
	for <mptcp@lists.linux.dev>; Thu, 18 Jun 2026 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751353; cv=none; b=VsqpTqNXIlo85xTd+xuhZqDdGKlxb+ReW4bYKARUx2UT0swEB1+XUi1RqUYXUT4wfoRHWYIurNMxGTfAAAhYrkzUVi4bUuw7t5GQoCArelG5Gj80Vhvz+LrSGRZ3a3WxzUoLvIhoi3Z8H5rNoQdFnHuXgvyZwGrJZ0rDZ233rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751353; c=relaxed/simple;
	bh=sd1q4paSXkpYQA+/gRU9bs0+7NcaQhcT0OpST45Vfis=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=ENaAzkYE1z4emi8owSUdr/m03fUl5eFSEm36brfknglL//gb2nCmW9MOOamdK+59z0HO71AOUNThj0DQgRr8Aaw5rHMthN1NeKikgni9GygaIH6B7FGfjgQYGxaHrGaWRzw5Pq/+O87W0uRyRv5VeHBO4areJ0Ey+IqvEQ0Qcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oxEtyS5s; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oxEtyS5s"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781751349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEZi+KmOZ6va6VDCptzln5v0GGsk8eG4Zj1T+SbhF0E=;
	b=oxEtyS5s95dtJKzhQdwZKCXYQ6paDMY6gxlXFidEBSApWgEr1PHgXpjswmyWB2k0I7AOhQ
	vUSVOu3KM/SbFYVjUtZ8bdTyp+M/KBzhk1jxO8gltNWiC6T94heHXJ229ciQ434juNpHbM
	6wWPA0r+cLV6BXiPaiWU0E/14SR6+fU=
Date: Thu, 18 Jun 2026 02:55:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <5e2e5ded267ad207d84932c653bbfa4b701f5e59@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2 0/9] selftests: mptcp: skip the v6 subtests
 when CONFIG_MPTCP_IPV6=n
To: mptcp@lists.linux.dev, matttbe@kernel.org
In-Reply-To: <cover.1781707101.git.yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

June 17, 2026 at 10:46 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan=
@linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:


Hi Matt,

As we discussed during yesterday's Weekly Meeting, I=E2=80=99ve quickly g=
one
through this patch series thread[1].

This patch converts CONFIG_IPV6 from a tristate option to a bool. From th=
e
discussion in the thread v1, ARM-based devices like mobile phones can sti=
ll
set CONFIG_IPV6=3Dn. In such cases, our CONFIG_MPTCP_IPV6 will also be di=
sabled,
which results in kselftest failures even when CONFIG_MPTCP=3Dy.

Given that, I believe it=E2=80=99s still valuable to mark and skip all IP=
v6-dependent
test cases within our self-test suite.=20

WDYT?

[1]=20https://lore.kernel.org/all/20260325120928.15848-2-fmancera@suse.de=
/

Thanks,
Gang

>=20
>=20From: Gang Yan <yangang@kylinos.cn>
>=20
>=20This series is for make the selftest useful in the kernel which IPV6 =
is
> compiled as a module.
>=20
>=20With this series applied, the output with CONFIG_IPV6=3Dm will be lik=
e:
>=20
>=20mptcp_connect.sh:
> '''
> Selftest Test: ./mptcp_connect.sh
> TAP version 13
> 1..1
> # [SKIP] MPTCP IPv6 support is not available
> # INFO: MPTCP IPv6 not available, running IPv4-only tests
> # INFO: set ns3-Ij7oet dev ns3eth2: ethtool -K gro off
> # INFO: set ns4-MNMck3 dev ns4eth3: ethtool -K tso off gso off
> # Created /tmp/tmp.MPGwnjy7S8 (size 7478906 B) containing data sent by =
client
> # Created /tmp/tmp.xLzF6OOxGG (size 1934300 B) containing data sent by =
server
> # 01 New MPTCP socket can be blocked via sysctl [ OK ]
> ...
> # 31 ns2 MPTCP -> ns1 (10.0.1.1:10028 ) MPTCP (duration 141ms) [ OK ]
> # INFO: with MPTFO end
> # /dev/stdin:2:1-2: Error: Could not process rule: Operation not suppor=
ted
> # table inet mangle {
> # ^^
> # /dev/stdin:2:12-17: Error: Could not process rule: No such file or di=
rectory
> # table inet mangle {
> # ^^^^^^
> # /dev/stdin:2:12-17: Error: Could not process rule: No such file or di=
rectory
> # table inet mangle {
> # ^^^^^^
> # /dev/stdin:2:12-17: Error: Could not process rule: No such file or di=
rectory
> # table inet mangle {
> # ^^^^^^
> # [SKIP] tproxy ipv4, could not load nft ruleset
> # INFO: nft inet table needs CONFIG_IPV6=3Dy
> # INFO: disconnect
> # 32 ns1 MPTCP -> ns1 (10.0.1.1:10029 ) MPTCP (duration 276ms) [ OK ]
> # 33 ns1 MPTCP -> ns1 (10.0.1.1:10030 ) TCP (duration 232ms) [ OK ]
> # 34 ns1 TCP -> ns1 (10.0.1.1:10031 ) MPTCP (duration 223ms) [ OK ]
> # Time: 55 seconds
> ok 1 test: selftest_mptcp_connect
> '''
>=20
>=20mptcp_sockopt.sh:
> '''
> Selftest Test: ./mptcp_sockopt.sh
> TAP version 13
> 1..1
> # [SKIP] MPTCP IPv6 support is not available
> # Created /tmp/tmp.xrhCxOCqCb (size 1 KB) containing data sent by clien=
t
> # Created /tmp/tmp.u2QBzkEsfF (size 1 KB) containing data sent by serve=
r
> # 01 Transfer v4 [ OK ]
> # 02 Mark v4 [ OK ]
> # 03 Transfer v6 [SKIP] MPTCP IPv6 not available
> # 04 Mark v6 [SKIP] MPTCP IPv6 not available
> # 05 SOL_MPTCP sockopt v4 [ OK ]
> # 06 SOL_MPTCP sockopt v6 [SKIP] MPTCP IPv6 not available
> # 07 TCP_INQ cmsg/ioctl -t tcp [ OK ]
> # 08 TCP_INQ cmsg/ioctl -6 -t tcp [SKIP] MPTCP IPv6 not available
> # 09 TCP_INQ cmsg/ioctl -r tcp [ OK ]
> # 10 TCP_INQ cmsg/ioctl -6 -r tcp [SKIP] MPTCP IPv6 not available
> # 11 TCP_INQ cmsg/ioctl -r tcp -t tcp [ OK ]
> ok 1 test: selftest_mptcp_sockopt
> # time=3D17
> '''
>=20
>=20simult_subflow.sh:
> '''
> Selftest Test: ./simult_flows.sh
> TAP version 13
> 1..1
> # [SKIP] MPTCP IPv6 support is not available
> # 01 balanced bwidth 7383 max 7906 [ OK ]
> # 02 balanced bwidth - reverse direction 7380 max 7906 [ OK ]
> # 03 balanced bwidth with unbalanced delay 7493 max 7906 [ OK ]
> # 04 balanced bwidth with unbalanced delay - reverse direction 7442 max=
 7906 [ OK ]
> # 05 unbalanced bwidth 11426 max 11921 [ OK ]
> # 06 unbalanced bwidth - reverse direction 11391 max 11921 [ OK ]
> # 07 unbalanced bwidth with unbalanced delay 11424 max 11921 [ OK ]
> # 08 unbalanced bwidth with unbalanced delay - reverse direction 11573 =
max 11921 [ OK ]
> # 09 unbalanced bwidth with opposed, unbalanced delay 11584 max 11921 [=
 OK ]
> # 10 unbalanced bwidth with opposed, unbalanced delay - reverse directi=
on11559 max 11921 [ OK ]
> ok 1 test: selftest_simult_flows
> # time=3D105
> '''
>=20
>=20./mptcp_join.sh:
> '''
> Selftest Test: ./mptcp_join.sh
> TAP version 13
> 1..1
> # [SKIP] MPTCP IPv6 support is not available
> # 001 no JOIN
> # join Rx [ OK ]
> # join Tx [ OK ]
> ...
> # 022 with multiple laminar endpoints
> # MPTCP IPv6 support is not available [SKIP]
> ...
> '''
>=20
>=20userspace_pm.sh:
> '''
> Selftest Test: ./userspace_pm.sh
> TAP version 13
> 1..1
> # [SKIP] MPTCP IPv6 support is not available
> # INFO: Init
> # 01 Created network namespaces ns1, ns2 [ OK ]
> # INFO: Make connections
> # INFO: Connection info: 10.0.1.2:47434 -> 10.0.1.1:50002
> # 03 Established IPv6 MPTCP Connection ns2 =3D> ns1 [SKIP]
> # INFO: Will be using address IDs 27 (client) and 31 (server)
> # INFO: Announce tests
> ...
> # 32 CREATE_LISTENER 10.0.2.2 (client port) [ OK ]
> # 33 CLOSE_LISTENER 10.0.2.2 (client port) [ OK ]
> # INFO: Cleanup
> # INFO: Done
> ok 1 test: selftest_userspace_pm
> # time=3D23
> '''
> ---
> Changelog:
> v2:
>  - Patch2 uses " mptcpv6_init(\.|$)" to replace " mptcpv6_init$", and
>  trims some code comments and commit message.
>  - Patch5 refactors IPv6 guards in mptcp_sockopt.sh, unifies skip logic=
,
>  removes redundant wrappers and duplicated title prints, and adds an
>  early v6 check for TCP_INQ tests.
>  - Patch6 removes 2 lines of redundant inline comment.
>  - Patch8 adds 'skip_if' helper, and rewrites all 29 IPv6 subtest guard=
s
>  in mptcp_join.sh to fix TAP log misordering and updates its commit
>  message with accurate test group info.
>  - Patch9 adds missing skip branches for seven IPv6 code paths in
>  userspace_pm.sh to generate proper TAP skip entries.
>=20
>=20v1:
>  Link: https://patchwork.kernel.org/project/mptcp/cover/cover.178119682=
8.git.yangang@kylinos.cn/
>=20
>=20Gang Yan (9):
>  DO-NOT-MERGE: mptcp: test IPV6=3Dm in docker-virtme
>  selftests: mptcp: mptcp_lib add runtime IPv6 availability detection
>  helper
>  selftests: mptcp: mptcp_connect.sh degrades to v4-only when MPTCP IPv6
>  is missing
>  selftests: mptcp: mptcp_connect.sh don't fail because of nft rules in
>  IPV6-less kernel
>  selftests: mptcp: mptcp_sockopt.sh skips v6 paths when MPTCP IPv6 is
>  missing
>  selftests: mptcp: simult_flows.sh skips v6 setup when MPTCP IPv6 is
>  missing
>  selftests: mptcp: mptcp_join.sh: pick v4 bind default when MPTCP IPv6
>  is missing
>  selftests: mptcp: mptcp_join.sh skips v6 subtests when MPTCP IPv6 is
>  missing
>  selftests: mptcp: userspace_pm.sh skips v6 paths when MPTCP IPv6 is
>  missing
>=20
>=20 tools/testing/selftests/net/mptcp/config | 5 +-
>  .../selftests/net/mptcp/mptcp_connect.sh | 48 +++-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++--
>  .../testing/selftests/net/mptcp/mptcp_lib.sh | 23 ++
>  .../selftests/net/mptcp/mptcp_sockopt.sh | 94 +++++--
>  .../selftests/net/mptcp/simult_flows.sh | 28 +-
>  .../selftests/net/mptcp/userspace_pm.sh | 257 ++++++++++--------
>  7 files changed, 391 insertions(+), 175 deletions(-)
>=20
>=20--=20
>=202.43.0
>
