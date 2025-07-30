Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CE1E5B64;
	Wed, 30 Jul 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866809; cv=none; b=P790SKxa4k/ROAwoSNHWDVxFYZdzOHZ8EmgjWnI6ghTBow9qkToyqCbyT0BWYCejbuBFAzFh62OJ2ZM4E+Rg7lI+6Xl+InHLDxx+22gbYCzIzM7W61FttRGXnr09swGMWoAj8cVOEWo+cxHE42CQqtgIdyYm3i2JQMoP5K6IJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866809; c=relaxed/simple;
	bh=RTerptDMBrbs3uXMAzF/CtryWEIRu+xDVS0fwWFc9Sg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=p9mO3aFPVieFEgtAFgymPyJ+Wk4kzVLj2ZY2ype7kKP2n7N0KLKoMp2e85oMURWmUVsqny8Hk9AtKiW0fylYK1/FU/zckSwFIcsHJjJYLeVvpPVd/wXMditoLcYMNU1ZvzpC+4boVakFMwRBsAYAROIy5lWSB8TvAYdBpejxmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZQCPNaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZQCPNaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAF3C4CEF5;
	Wed, 30 Jul 2025 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753866809;
	bh=RTerptDMBrbs3uXMAzF/CtryWEIRu+xDVS0fwWFc9Sg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=VZQCPNaf/Lj4K2SpEeyvRWiAo5ceW8UKHn5T+1sLKpF8L/+56w2JEuTo2mdJlipjS
	 0Ueeus5pVf8yR843hlw947qAYMIvtbv5EEOmwlUBKrEghcolJ1C5FTwpo9Sj0PSflU
	 Ydu047Zj67fE+FquMCq4TqSSssCDRkNDS9qs1j+0=
Subject: Patch "mptcp: reset fallback status gracefully at disconnect() time" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 11:13:04 +0200
In-Reply-To: <20250728091448.3494479-8-matttbe@kernel.org>
Message-ID: <2025073004-ferocity-uplifting-2364@gregkh>
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

    mptcp: reset fallback status gracefully at disconnect() time

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-reset-fallback-status-gracefully-at-disconnect-time.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-164898-greg=kroah.com@vger.kernel.org Mon Jul 28 11:15:34 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 28 Jul 2025 11:14:51 +0200
Subject: mptcp: reset fallback status gracefully at disconnect() time
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250728091448.3494479-8-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit da9b2fc7b73d147d88abe1922de5ab72d72d7756 upstream.

mptcp_disconnect() clears the fallback bit unconditionally, without
touching the associated flags.

The bit clear is safe, as no fallback operation can race with that --
all subflow are already in TCP_CLOSE status thanks to the previous
FASTCLOSE -- but we need to consistently reset all the fallback related
status.

Also acquire the relevant lock, to avoid fouling static analyzers.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3208,7 +3208,16 @@ static int mptcp_disconnect(struct sock
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	msk->can_ack = false;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-6.6/selftests-mptcp-connect-also-cover-checksum.patch
queue-6.6/mptcp-plug-races-between-subflow-fail-and-subflow-creation.patch
queue-6.6/mptcp-make-fallback-action-and-fallback-decision-atomic.patch
queue-6.6/mptcp-reset-fallback-status-gracefully-at-disconnect-time.patch
