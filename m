Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FD290A
	for <mptcp@lists.linux.dev>; Fri, 28 Apr 2023 11:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FDC433D2;
	Fri, 28 Apr 2023 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1682680531;
	bh=BYi5kb6OpFQwB7hBlqRg75uFxY/ycJhOeppZMDch/dM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=S/T4O5gmhDW18TE6JloX9AfRpXUvN4xmOatwIwzw7MzFY1mE1uCGPzJo4+8dVZrG1
	 I0u06id4qw8UNVy7ryss+XTPQ6nMdqdasLcvdxRHxSHdE6hs+KkXCsnH+ED6bIg5b9
	 wbj0MFekWCHP3ic8ManmET8UTxTvojD3yKQEO/Zk=
Subject: Patch "selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matthieu.baerts@tessares.net,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 28 Apr 2023 13:15:15 +0200
In-Reply-To: <20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22@tessares.net>
Message-ID: <2023042814-flannels-slider-832e@gregkh>
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

    selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-fix-invalid-address-add_addr-timeout.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matthieu.baerts@tessares.net  Fri Apr 28 13:12:10 2023
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 28 Apr 2023 11:43:46 +0200
Subject: selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22@tessares.net>

From: Matthieu Baerts <matthieu.baerts@tessares.net>

The "Fixes" commit mentioned below adds new MIBs counters to track some
particular cases that have been fixed by its parent commit 150d1e06c4f1
("mptcp: fix race in incoming ADD_ADDR option processing").

Unfortunately, one of the new MIB counter (AddAddrDrop) shares the same
prefix as an older one (AddAddr). This breaks one selftest because it
was doing a grep on "AddAddr" and it now gets 2 counters instead of 1.

This issue has been fixed upstream in a commit that was part of the same
set but not backported to v5.15, see commit 6ef84b1517e0 ("selftests:
mptcp: more robust signal race test"). It has not been backported
because it was fixing multiple things, some where for >v5.15.

This patch then simply extracts the only bit needed for v5.15. Now the
test passes when validating the last stable v5.15 kernel.

Fixes: f25ae162f4b3 ("mptcp: add mibs counter for ignored incoming options")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -732,7 +732,7 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"


Patches currently in stable-queue which might be from matthieu.baerts@tessares.net are

queue-5.15/selftests-mptcp-join-fix-invalid-address-add_addr-timeout.patch
