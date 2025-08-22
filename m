Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9C284669;
	Fri, 22 Aug 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870334; cv=none; b=Y99cHvKJikI3YIHNqdWOPjvMpCCO/zv7UEU9HKjxHUgSopg3VaD2cJIHyq9hFWlXjQO0NCLUJx5yQ6zZgAB3yobWE7Pz26Nw1VDwUFxhGuzQnBCK5O8ObvplWXGrVxKQv68olkBiis5tyIK69ZpvYlJNuZP+bwKW+XWYRhYeH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870334; c=relaxed/simple;
	bh=Wp7+a/WAuDHp8kuPpWvyhF28Aqap+EkRbWtrJQHHdjM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ftNJ8iRaOQtAFIHicKxjmONdxGKVlOxqlaMd6+HOlEO6X4ADQcKuFYqDKLN+msxuI2yGy0jzwqNloXHxTbh1WoRw6GefmOCIrSh+zQujY7+x0vbxE0HWFyaoVAMg9Us9PFNTLOIkb5xWQOeuqmz8RgmONDTq7kBWJm3rnpDAVrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVC5XAgl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVC5XAgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15EFC4CEED;
	Fri, 22 Aug 2025 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870334;
	bh=Wp7+a/WAuDHp8kuPpWvyhF28Aqap+EkRbWtrJQHHdjM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=AVC5XAgllATrJe8QpUWBH15/u4XDVoHe1HVBrbKJv0DljaLGOAUiagDTpvkF8QAmV
	 1Hhr0+CTn5ot1ilemyNpLhotWL7Op6sOtnkEru7yQOmxnjOrVs7HkEcHp4+459mtI8
	 6ptFG44oUt7rd4LOCW5jLy7jWCXS+JjtPnYYF4Lg=
Subject: Patch "selftests: mptcp: Initialize variables to quiet gcc 12 warnings" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:35 +0200
In-Reply-To: <20250731112353.2638719-12-matttbe@kernel.org>
Message-ID: <2025082235-playlist-blinks-9590@gregkh>
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

    selftests: mptcp: Initialize variables to quiet gcc 12 warnings

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-initialize-variables-to-quiet-gcc-12-warnings.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165649-greg=kroah.com@vger.kernel.org Thu Jul 31 13:24:27 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 31 Jul 2025 13:23:58 +0200
Subject: selftests: mptcp: Initialize variables to quiet gcc 12 warnings
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, sashal@kernel.org, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250731112353.2638719-12-matttbe@kernel.org>

From: Mat Martineau <mathew.j.martineau@linux.intel.com>

commit fd37c2ecb21f7aee04ccca5f561469f07d00063c upstream.

In a few MPTCP selftest tools, gcc 12 complains that the 'sock' variable
might be used uninitialized. This is a false positive because the only
code path that could lead to uninitialized access is where getaddrinfo()
fails, but the local xgetaddrinfo() wrapper exits if such a failure
occurs.

Initialize the 'sock' variable anyway to allow the tools to build with
gcc 12.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ mptcp_inq.c and mptcp_sockopt.c are not in this version. The fix can
  still be applied in mptcp_connect.c without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -188,7 +188,7 @@ static void set_mark(int fd, uint32_t ma
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
-	int sock;
+	int sock = -1;
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,


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
