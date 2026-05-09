Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8B26B08F
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778310427; cv=none; b=Y4eOAny7mNtvZR3X3EXA4fj//9rNqB+z1phFIXM2jq922KEojk48oiPn5thLnHxduqV+ZncacIgYogpS38aQVVb//UtimaYyVeXqtTUnCMKS0MlYkAoyzF4K3ANqV3G6HlRhDrmR/qEwZk+qhRwEeJxAZHFZ3Iwy6mLdHGBmOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778310427; c=relaxed/simple;
	bh=73/FNnZ0Zh50gqDjEksfnpL+6HIqsjFSIQjwKqQVe/w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=IK/vP/FZqvRGnmVxKMviD9OLWiMvrwqVG5QUmSalD0LdaFFlfwnkVk9t/ZkFIlEkQWebm1TWyXbhrpOYPDfKLLvf7bgHifxmEkIm3YYTdGzGD1KOjZ/t8yJV6fBZyAYz1IU6JiIH92wlWxFytSmhGjhjoue6A4TddwrWaip/m8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hqV5jT8Q; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hqV5jT8Q"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778310423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywYGMcsTYPyD0iod5NkNFxxEGNFL3WtqENBueKYmZdw=;
	b=hqV5jT8Qk2f0+3cuGjepoMR5UmZA+jsMC3eOHpUgY50JMZo0cMvHxier+BzsL0o+67GFBU
	Rm3tWLTlZ5Jy1X7Gi8L3L8Wa/NBVMSroqj5hkdaNPFfYDLjGe2gCOdbcWr3Xokm6CFfVea
	PdHxrjjP25SS9eG6tuZCxul4U2O9PW4=
Date: Sat, 09 May 2026 07:07:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <47cae42a6de0745a423098d1b15bdd71dc2937d6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory
 pressure
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <cc137cc2-718f-41e9-aabd-e65b9fbfd4ee@kernel.org>
References: <cover.1777908248.git.pabeni@redhat.com>
 <cc137cc2-718f-41e9-aabd-e65b9fbfd4ee@kernel.org>
X-Migadu-Flow: FLOW_OUT

May 8, 2026 at 6:49 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matt=
tbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E =
> wrote:


>=20
>=20Hi Geliang, Gang,
>=20
>=20On 04/05/2026 17:39, Paolo Abeni wrote:
>=20
>=20>=20
>=20> This an attempt to fix the data transfer stall reported by Geliang =
and
> >  Gang more carefully enforcing memory constraints at the MPTCP level.
> >=20=20
>=20>  Patch 1/10 moves the bound check before entering the TCP socket.
> >  Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely re-us=
ing
> >  TCP helpers on MPTCP skbs.
> >  Patch 6 makes TCP pruning related helpers available to MPTCP and pat=
ch 7
> >  makes use of them. Patch 8 addresses an edge scenario that could sti=
ll
> >  lead to transfer stall under memory pressure.
> >  Finally patch 9 and 10 improve the MPTCP-level retransmission schema=
 to
> >  make recovery from memory pressure significanly faster.
> >=20=20
>=20>  Note that the diffstat is biases by the quite large patch 4/9, whi=
ch
> >  contains mechanical transformation of existing code; "real" changes =
are
> >  noticiable smaller.
> >=20=20
>=20>  Tested successfully vs the test cases proposed by Geliang and Gang=
 and
> >  vs the selftests.
> >=20
>=20At the last meeting on Wednesday, Geliang mentioned he validated this
> series. Just to be sure, was it the v2 -- from last week -- or the v3 -=
-
> from this week, while you were in EU -- that you validated? Because
> Paolo couldn't reproduce the issue you mentioned on the v3 on his side.
>=20
Hi,=20Matt

The issue can also be reproduced on v3. I reproduced it using Docker's
auto-debug mode with the mptcp_data.sh selftest:

=E2=80=98=E2=80=99=E2=80=98
	Not running all tests but:

-------- 8< --------
run_loop run_selftest_one mptcp_data.sh
-------- 8< --------




	=3D=3D=3D Attempt: 1 (Sat, 09 May 2026 06:55:44 +0000) =3D=3D=3D


Selftest Test: ./mptcp_data.sh
TAP version 13
1..1
# add_addr_accepted 4 subflows 4=20
#=20id 1 flags signal 127.0.0.1 10001
# id 2 flags signal 127.0.0.1 10002
# id 3 flags signal 127.0.0.1 10003
# id 4 flags signal 127.0.0.1 10004
# TAP version 13
# 1..48
# # Starting 48 tests from 2 test cases.
# #  RUN           global.mptcp_v6 ...
# #            OK  global.mptcp_v6
# ok 1 global.mptcp_v6
# #  RUN           mptcp.shutdown_reuse ...
# #            OK  mptcp.shutdown_reuse
# ok 2 mptcp.shutdown_reuse
...
# ok 48 mptcp.sendfile
# # FAILED: 41 / 48 tests passed.
# # Totals: pass:41 fail:7 xfail:0 xpass:0 skip:0 error:0
not ok 1 test: selftest_mptcp_data # FAIL
# time=3D33
=E2=80=99=E2=80=98=E2=80=99

As Geliang mentioned in the weekly meeting, we will continue
to debug and locate the problem based on Paolo's v3 patches.

We will post any updates to the mailing list once we make
some progess.

Thanks
Gang
> Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
