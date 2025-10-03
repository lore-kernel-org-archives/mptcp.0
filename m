Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F113C3F2;
	Fri,  3 Oct 2025 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496258; cv=none; b=BngBUQn5P5Zb7iceOg4fHxIztlx0EdEJXwRE5GitGwpJ1RGMP1+llrtB6kPIqRwes1FJxecha7Y5dmAv8LAoMZrZ4Yq1zLgPgg/QmIHzE4BSv3rx+T1fNLJmabvLAm2m8GYVG/2M6jsJHks7O5uA8xJS5XnTSTXUmdNWLy97TmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496258; c=relaxed/simple;
	bh=7UWJr9ZkVgQWu9OJYy4iDL89Ec3TltrY6VUsBMJd+qo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=HT/f79lv5U1GjWHy6cItbWiqot4OmP8k1tFP6bVMK56j9No4RkeEjOUGSETy06j0Cmeb65juOG1tPSczxdSYzvpl/89pf3LWOhZ/2TM3B5UxW3XO7Lx90n6Xxrl5y0JUvR6eoH7CkoRNy+lT3nXHP0pWYEsVnPnI9/ONMFuOlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlrGzlNo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlrGzlNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AECC4CEF5;
	Fri,  3 Oct 2025 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759496258;
	bh=7UWJr9ZkVgQWu9OJYy4iDL89Ec3TltrY6VUsBMJd+qo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ZlrGzlNoY21VPM4SA+GrUmOxWhN4h+zO7/5rT/zESZpQIhQ6RTQQjV1wsExuvgBrR
	 fGg9p4se8BcDvqJyK1DZgsv9N2jp/O98Htee/GHBY45AB0ZIAaleyFY6bGTat+V6ij
	 hKHtb4d4pIDRqBHIUKJSXstJekAns3/Qyw3N5DK0=
Subject: Patch "selftests: mptcp: connect: fix build regression caused by backport" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,k@mgml.me,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 14:57:35 +0200
In-Reply-To: <20251002141759.76891-1-k@mgml.me>
Message-ID: <2025100335-qualifier-smuggling-e544@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    selftests: mptcp: connect: fix build regression caused by backport

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-connect-fix-build-regression-caused-by-backport.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From k@mgml.me  Fri Oct  3 14:56:36 2025
From: Kenta Akagi <k@mgml.me>
Date: Thu,  2 Oct 2025 23:17:59 +0900
Subject: selftests: mptcp: connect: fix build regression caused by backport
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>, Kenta Akagi <k@mgml.me>
Message-ID: <20251002141759.76891-1-k@mgml.me>

From: Kenta Akagi <k@mgml.me>

Since v6.1.154, mptcp selftests have failed to build with the following
errors:

mptcp_connect.c: In function ‘main_loop_s’:
mptcp_connect.c:1040:59: error: ‘winfo’ undeclared (first use in this function)
 1040 |                 err = copyfd_io(fd, remotesock, 1, true, &winfo);
      |                                                           ^~~~~
mptcp_connect.c:1040:59: note: each undeclared identifier is reported only once for each function it appears in
mptcp_connect.c:1040:23: error: too many arguments to function ‘copyfd_io’; expected 4, have 5
 1040 |                 err = copyfd_io(fd, remotesock, 1, true, &winfo);
      |                       ^~~~~~~~~                          ~~~~~~
mptcp_connect.c:845:12: note: declared here
  845 | static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
      |            ^~~~~~~~~

This is caused by commit ff160500c499 ("selftests: mptcp: connect: catch
IO errors on listen side"), a backport of upstream 14e22b43df25,
which attempts to use the undeclared variable 'winfo' and passes too many
arguments to copyfd_io(). Both the winfo variable and the updated
copyfd_io() function were introduced in upstream
commit ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener"),
which is not present in v6.1.y.

The goal of the backport is to stop on errors from copyfd_io.
Therefore, the backport does not depend on the changes in upstream
commit ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener").

This commit simply removes ', &winfo' to fix a build failure.

Fixes: ff160500c499 ("selftests: mptcp: connect: catch IO errors on listen side")
Signed-off-by: Kenta Akagi <k@mgml.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1037,7 +1037,7 @@ again:
 
 		SOCK_TEST_TCPULP(remotesock, 0);
 
-		err = copyfd_io(fd, remotesock, 1, true, &winfo);
+		err = copyfd_io(fd, remotesock, 1, true);
 	} else {
 		perror("accept");
 		return 1;


Patches currently in stable-queue which might be from k@mgml.me are

queue-6.1/selftests-mptcp-connect-fix-build-regression-caused-by-backport.patch
