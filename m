Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86691286A6
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130977; cv=none; b=u2PgnFtlbqqkqx3kcgVLaAx0HNWDYUHoHDaDrf/FK53FcPjqUC+qWRkDRJla+1+U/L01I7E1ybkhirCIla3IOB+YYvtWMZhVt0pWs3SUG+Sj/WlKCSMktMsddYe0qDdCuyw476Dtu3V7tH3TjqBAfT+xrPtZddttKZZ8z68SKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130977; c=relaxed/simple;
	bh=m+4WcDdbhP81f6A67Khk/FivhY0k85d0KK8LZIc6zTs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QzTbORoNKClAxdBIR4SV2mwEl5QH3h32PJ3RINoGBKCg0+s8pI5ZrEiF5dxRAybIBVs4tni0cuX8bxG4lkp+He+1GdSWhkXoO1fnX97gAWdSembxOAoQLUQRm/WyEu+TAneqVMrjjYT3EhTFlxsoBdvdGTovTMpfDlJMz0d9i0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21b74ce2f18e11eeaf09c5092e5928d1-20240403
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d3c12111-9356-4fa5-977e-21620eee6f9d,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.1.37,REQID:d3c12111-9356-4fa5-977e-21620eee6f9d,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:4499c1e6903026cfe423f2bee8503f9a,BulkI
	D:240403154525UXXO5D1I,BulkQuantity:0,Recheck:0,SF:66|24|100|16|101|74|64|
	42|19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 21b74ce2f18e11eeaf09c5092e5928d1-20240403
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <tanggeliang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 521322946; Wed, 03 Apr 2024 15:45:24 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 9DED716001CC9
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 15:45:24 +0800 (CST)
X-ns-mid: postfix-660D0914-522039912
Received: from [172.30.60.235] (unknown [172.30.60.235])
	by node4.com.cn (NSMail) with ESMTPA id 7E97A16001CC9
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:45:24 +0000 (UTC)
Message-ID: <cefdf3b0414d664f2d797060460c4de7b4cc1d97.camel@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 01/10] Squash to "selftests/bpf: Add bpf
 scheduler test" 1 nonblock
From: Geliang Tang <tanggeliang@kylinos.cn>
To: mptcp@lists.linux.dev
Date: Wed, 03 Apr 2024 15:45:23 +0800
In-Reply-To: <f0b66813ae8274e5653988d80d16171508f05796.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
	 <f0b66813ae8274e5653988d80d16171508f05796.1712042049.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2024-04-02 at 15:15 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> BPF tests fail sometimes with "bytes !=3D total_bytes" errors:
>=20
> =C2=A0# test_default:PASS:sched_init:default 0 nsec
> =C2=A0# send_data:PASS:pthread_create 0 nsec
> =C2=A0# send_data:FAIL:recv 936000 !=3D 10485760 nr_recv:-1 errno:11
> =C2=A0# default: 3041 ms
> =C2=A0# server:FAIL:send 7579500 !=3D 10485760 nr_sent:-1 errno:11
> =C2=A0# send_data:FAIL:pthread_join thread_ret:-11 \
> 		test_default:PASS:has_bytes_sent addr_1 0 nsec
> =C2=A0# test_default:PASS:has_bytes_sent addr_2 0 nsec
> =C2=A0# close_netns:PASS:setns 0 nsec
>=20
> Here errno 11 is EAGAIN. This patch sets server socket to nonblock
> to fix this. It makes BPF tests stable.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> =C2=A0tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 6e28215d7404..d3d51aee440d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -88,6 +88,16 @@ static void cleanup_netns(struct nstoken *nstoken)
> =C2=A0	SYS_NOFAIL("ip netns del %s", NS_TEST);
> =C2=A0}
> =C2=A0
> +static int set_nonblock(int fd)
> +{
> +	int flags =3D fcntl(fd, F_GETFL);
> +
> +	if (flags =3D=3D -1)
> +		return -1;
> +
> +	return fcntl(fd, flags | O_NONBLOCK);

This fix is incorrect. fcntl shouldn't be used like this. I'll think
about how to modify it again. BTW, Other patches in this series are
still valid. But needs to be rebased.

Thanks,
-Geliang

> +}
> +
> =C2=A0static int verify_tsk(int map_fd, int client_fd)
> =C2=A0{
> =C2=A0	int err, cfd =3D client_fd;
> @@ -466,6 +476,7 @@ static void test_default(void)
> =C2=A0	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> =C2=A0	client_fd =3D connect_to_fd(server_fd, 0);
> =C2=A0
> +	set_nonblock(server_fd);
> =C2=A0	send_data(server_fd, client_fd, "default");
> =C2=A0	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
> =C2=A0	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
> @@ -639,6 +650,7 @@ static void test_burst(void)
> =C2=A0	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> =C2=A0	client_fd =3D connect_to_fd(server_fd, 0);
> =C2=A0
> +	set_nonblock(server_fd);
> =C2=A0	send_data(server_fd, client_fd, "bpf_burst");
> =C2=A0	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
> =C2=A0	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");

