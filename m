Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D950200AC
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 17:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E55DC433C8;
	Thu, 22 Jun 2023 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687454008;
	bh=G6s807a3xA5yU5/ajk/4y0YibtWH85qX0s819juhP4s=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=nvSx/jJecQ4gUyER5bT7rjdT8FBkMDYWm0azn/ifRz6TlyUii3V0p6PJDpIHhXZGx
	 dtMe49oZ7/qjR4ltIeK7DCqqNFsReqKIYv23SmbYX9Shj8GN5CHiAHzspSyhsuj1D4
	 x2DK508fH24VJXxwLhE7wL4wClk8t0LzSi204fC4=
Subject: Patch "selftests: mptcp: join: fix "userspace pm add & remove address"" has been added to the 6.1-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,matthieu.baerts@tessares.net,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Jun 2023 19:13:10 +0200
In-Reply-To: <20230622154307.3362179-1-matthieu.baerts@tessares.net>
Message-ID: <2023062209-undertake-repaint-f98f@gregkh>
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

    selftests: mptcp: join: fix "userspace pm add & remove address"

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-fix-userspace-pm-add-remove-address.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Thu Jun 22 17:43:24 2023
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 22 Jun 2023 17:43:07 +0200
Subject: selftests: mptcp: join: fix "userspace pm add & remove address"
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <20230622154307.3362179-1-matthieu.baerts@tessares.net>

From: Matthieu Baerts <matthieu.baerts@tessares.net>

It looks like this test was broken in v6.1 after the backport of commit
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests").

It was not working because the commit ad3493746ebe ("selftests: mptcp:
add test-cases for mixed v4/v6 subflows") is not in v6.1. This commit
changes how the connections are being created in mptcp_join.sh selftest:
with IPv6 support always enabled. But then in v6.1, the server still
create IPv4 only connections, so without the v4-mapped-v6 format with
the "::ffff:" prefix like we have in v6.3.

The modification here adds a support for connections created in v4 as
well so it fixes the issue in v6.1. This patch is not needed for the
selftests in v6.3 because only IPv6 listening sockets are being created.

Fixes: 8f0ba8ec18f5 ("selftests: mptcp: update userspace pm addr tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -946,11 +946,12 @@ do_transfer()
 				sp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				     sed -n 's/.*\(daddr[46]:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				echo "$da" | grep -q ":" && addr="::ffff:$addr"
 				dp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "$addr" \
 							lport $sp rip $da rport $dp token $tk
 			fi
 


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-6.1/selftests-mptcp-join-fix-userspace-pm-add-remove-address.patch
queue-6.1/selftests-mptcp-join-skip-userspace-pm-tests-if-not-supported.patch
queue-6.1/selftests-mptcp-join-skip-test-if-iptables-tc-cmds-fail.patch
