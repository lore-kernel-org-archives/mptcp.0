Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001732FC037;
	Fri, 22 Aug 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870302; cv=none; b=WA7PoaDcBFuqufu8bAeiQrPqpKNWc/jWFisSE0Xq1GytgARyx+3EMfDBFaDIL19TSz4PJUPOeNWxyJAP3RMxzeanjKiY3WtF3jlSfYuNMkTZ6g+5FzLG6b8EMzBhz3eY3Oib/HcMbuinTs5cCEvSwjvmAVuGpHx3Uhopp+bcZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870302; c=relaxed/simple;
	bh=xI/f9mBgeAfjIahCp7z7rr87cw0ANBZFpcGl2UMIGbI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=AsQzTQXU0lLpu668gq0vvkGs5P1c//qiYzWRpmXHus/dxQw0vhx2WYphApYMbb0LzUGJiiLU5aDVBGebUcCVxNPkc8lLTEEaOKkJxb8Ii04t9NVj8SJjAKwJ8LqdLMM18Fwqz61Dxu5eTxKGfPSouRiZMj/Zp7Lj+VLG0JYZNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=crm0p/f1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="crm0p/f1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046E8C113CF;
	Fri, 22 Aug 2025 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870301;
	bh=xI/f9mBgeAfjIahCp7z7rr87cw0ANBZFpcGl2UMIGbI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=crm0p/f1w0SCa1Sa0+gmPGtwY4j3Y2ikU7rmkozv7Z6PeObIVjFatK4hBH0LYsHNf
	 A9RvOHvbw3r7HKJtTPWso1d5dYGg0T8MoIWEHgvYfFxjevJaAfVHj8cTkqeS6jYsMK
	 qdWClrWUkpk9vnEbZUjbSq1p/MLAqf0K+v1EZMWs=
Subject: Patch "mptcp: fix error mibs accounting" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:34 +0200
In-Reply-To: <20250731112353.2638719-10-matttbe@kernel.org>
Message-ID: <2025082234-unchain-washboard-afab@gregkh>
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

    mptcp: fix error mibs accounting

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-error-mibs-accounting.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165647-greg=kroah.com@vger.kernel.org Thu Jul 31 13:24:24 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 31 Jul 2025 13:23:56 +0200
Subject: mptcp: fix error mibs accounting
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250731112353.2638719-10-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 0c1f78a49af721490a5ad70b73e8b4d382465dae upstream.

The current accounting for MP_FAIL and FASTCLOSE is not very
accurate: both can be increased even when the related option is
not really sent. Move the accounting into the correct place.

Fixes: eb7f33654dc1 ("mptcp: add the mibs for MP_FAIL")
Fixes: 1e75629cb964 ("mptcp: add the mibs for MP_FASTCLOSE")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts, because commit f284c0c77321 ("mptcp: implement fastclose
  xmit path") is not in this version. That's OK, the new helper added
  by this commit doesn't need to be modified. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    1 +
 net/mptcp/subflow.c |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -793,6 +793,7 @@ static bool mptcp_established_options_mp
 	opts->fail_seq = subflow->map_seq;
 
 	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 
 	return true;
 }
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -963,10 +963,8 @@ static enum mapping_status validate_data
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen) {
+		if (subflow->mp_join || subflow->valid_csum_seen)
 			subflow->send_mp_fail = 1;
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
-		}
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-drop-unused-sk-in-mptcp_push_release.patch
queue-5.15/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-5.15/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-5.15/selftests-mptcp-connect-also-cover-checksum.patch
queue-5.15/selftests-mptcp-make-sendfile-selftest-work.patch
queue-5.15/selftests-mptcp-initialize-variables-to-quiet-gcc-12-warnings.patch
queue-5.15/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-5.15/mptcp-do-not-queue-data-on-closed-subflows.patch
queue-5.15/selftests-mptcp-add-missing-join-check.patch
queue-5.15/mptcp-fix-error-mibs-accounting.patch
queue-5.15/mptcp-introduce-mapping_bad_csum.patch
