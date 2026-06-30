Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53D306776
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816470; cv=none; b=SgcQjdCiph5CWwD6LrXmldzWWboMw1mDu0tJByXaXoBXguzoatWGPfHwTOrgHgjdm4FvMcWYTtefnKShZ2FbNgTTVCVCKjaDK1hqCV+XJBgFgppxOfdM8VrSBMa51cmWcZx16tqtByGO1jhip9+RpeVSqCKT+Zdd01cZrVGuCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816470; c=relaxed/simple;
	bh=eDv+WoP1K3JbdAUkHLmI1jYI/tlyFdlsYkYxQqJj6RY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RB0uuZx+y4i6own4X3XeckiTvdIFTc5dwZofgI/aD2p0gdVUDCmuRTcAc436L6lh+cbIYAtfHTjIRqb0TeUDai25P2bYs5/+f9hlhk5MsI2U3/JJjVZ4D5+rj0eblYF6vlDa0rsdqfa+nCTndvjXEePM7xcbzIEANV5aNk6/IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0yX/k6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0yX/k6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A941F000E9;
	Tue, 30 Jun 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816465;
	bh=Jj3poqyAhNschGvSmDMYmk/1HgcHOgShcwuyx7c7dv4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=f0yX/k6HQOjQP/j8zzBIjmz9RAOiSV+/EnMBr8EJz/2iojyllD/EOeOWz4gn47180
	 y71PDrDYMTczs1+y+KMDUrp1wYNnzponp5wg2ctW4Wpm4WnZmrX1aOj9jXYpVu4iMw
	 cehXivfzq+KizUc0g3OAOqSSBb31ZbD3NXNxYPpzWo0z+XUbq1vNwzBqIePlAyTL7a
	 V+REd1Dt/nWj9qFDrpJHqH19+bxT0drpaBOr3D4ccKuQtsjG3Q+q+19gXyTedG50JV
	 vil2PBhc0npeQ6F90PHB8Cnj8n1Bth5EH07xeq/YemMo3c0+GRajn8iL6afZ9fx70B
	 PDMB6fDW22CWA==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net] mptcp: fix extra_subflows leak on failed
 passive join
From: Matthieu Baerts <matttbe@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: mptcp@lists.linux.dev, Chenguang Zhao <zhaochenguang@kylinos.cn>
In-Reply-To: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
References: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
Date: Tue, 30 Jun 2026 12:47:37 +0200
Message-Id: <178281645760.2535326.10938187030246254056.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eDv+WoP1K3JbdAUkHLmI1jYI/tlyFdlsYkYxQqJj6RY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKc511olvq1kKHJfvLcDpmsf5lpSc8fLRR1LGa1fvry2
 a3UdaaWHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZ8JORYYXQ9mbJYud7m5NC
 Pnz7e+vAm5avwf/YE87KXI12Zhf1+srwz5zh0N5Jb5TXLmx9v+O6VpvaqejGRsYNlzffufCvzuK
 vBDsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi Chenguang,

Thank you for the fix.

> mptcp_pm_allow_new_subflow() increments extra_subflows
> before __mptcp_finish_join() on the passive MP_JOIN path.

I see that this code path is currently not exercised by our test suite:

  https://ci-results.mptcp.dev/lcov/export/mptcp/protocol.c.gcov.html#L4031

How did you spot the issue? Do you have a reproducer? Or was it by
reading the code? Assisted by a tool (in this case, please add the
Assisted-by tag)?

I see we have a test for sync connect failure, but not sync join. Do you
mind adding a new Packetdrill test please? Similar to simult_connect.pkt
I suppose:

  https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/syscalls/simult_connect.pkt

> On synchronous join failure the subflow is dropped without
> calling mptcp_close_ssk(), so the counter is not rolled back.
>
> Call mptcp_pm_close_subflow() when the join completion fails.

A fix patch should always have a Fixes tag. Here, I guess it should be:

Fixes: 10f6d46c943d ("mptcp: fix race between MP_JOIN and close")

Apart from that, the modification looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
