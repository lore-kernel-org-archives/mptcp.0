Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A875817;
	Wed, 19 Jun 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793668; cv=none; b=qgiRJaBL14Gzt29wPrnnuAGR9yoozGnBgwTAUcfJR23wifka7gbPsRjcrc/am08OtgwII7udaMJIuosB/qYiSyZDICt3qKdvdtfMvZgpUMhKoq6EIEwI9jhuv0X4y4SImz4yCBX3o9bX/gBr+5Yb9GiZF7r/5dAE+98EysT5pbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793668; c=relaxed/simple;
	bh=zNuWAK2T2CflgY19QKbfzRQl/BBjeg0CnrigbNWTZQs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Sn1LHxE3Wd8+ArLYAO+5PUYO6IuZr0HCavXi95w0+mRnPnLvnoktAfOigcuGnPqo8h5ZlVIFwr4JGDZe6Bjpz6bYalfz9Z+ndX6HTZ4NRnGC9XsAv9tD/6ye3HJCWqBGUT4ab/QuGiYaw1ZMEQsIztAJPux/apVouRoa+Agvudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1qqoY1t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1qqoY1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC687C2BBFC;
	Wed, 19 Jun 2024 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718793667;
	bh=zNuWAK2T2CflgY19QKbfzRQl/BBjeg0CnrigbNWTZQs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=I1qqoY1txPaWEpzEH3K+cLCs2NvvF5++3zey5JtCX4NfoF5SEoZMUxxkJ+EF+caFy
	 9Zk6f/Y18giLdM17RHGq3RX4wDUje7yX7Kx2ogjlz4cxYDGO1GAHt47Hh+w8YCk1OQ
	 xF7SPwVOpHI5uLY8eHUekqKgN/1RlWDVarjKvoE8=
Subject: Patch "mptcp: ensure snd_una is properly initialized on connect" has been added to the 5.10-stable tree
To: cpaasch@apple.com,gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 12:41:04 +0200
In-Reply-To: <20240618122444.640369-2-matttbe@kernel.org>
Message-ID: <2024061903-overtake-shame-2125@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: ensure snd_una is properly initialized on connect

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-ensure-snd_una-is-properly-initialized-on-connect.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-52669-greg=kroah.com@vger.kernel.org Tue Jun 18 14:25:14 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Jun 2024 14:24:45 +0200
Subject: mptcp: ensure snd_una is properly initialized on connect
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Christoph Paasch <cpaasch@apple.com>, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240618122444.640369-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 8031b58c3a9b1db3ef68b3bd749fbee2e1e1aaa3 upstream.

This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
is properly initialized on connect"). It turns out that syzkaller can
trigger the retransmit after fallback and before processing any other
incoming packet - so that snd_una is still left uninitialized.

Address the issue explicitly initializing snd_una together with snd_nxt
and write_seq.

Suggested-by: Mat Martineau <martineau@kernel.org>
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-1-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, similar to the ones from commit 99951b62bf20
  ("mptcp: ensure snd_nxt is properly initialized on connect"), with the
  same resolution. Note that in this version, 'snd_una' is an atomic64
  type, so use atomic64_set() instead, as it is done everywhere else. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2646,6 +2646,7 @@ static int mptcp_stream_connect(struct s
 		mptcp_subflow_early_fallback(msk, subflow);
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	atomic64_set(&msk->snd_una, msk->write_seq);
 
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-pm-inc-rmaddr-mib-counter-once-per-rm_addr-id.patch
queue-5.10/mptcp-ensure-snd_una-is-properly-initialized-on-connect.patch
queue-5.10/mptcp-pm-update-add_addr-counters-after-connect.patch
