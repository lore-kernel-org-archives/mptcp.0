Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB11A35
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644863714; x=1676399714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RGockvoKL+uvWQsK8KMJ+92l3IsfxPsTQyP6OjEV8cE=;
  b=EXtjpPj9dzNjBCLRA2J4vbkmVlTCnZmqOkRD5rP5gnY+MH2ruNtbf5GD
   U8df0WN9vmnZjJai6by1aRfYJPVzsnOjzg8JGfs7nAC3Orm6QC0RtAx5T
   m3PwVtyi8yb7tMi/jRBaPdCWdzzhekZAyMzmCt5KRsw3lMAKG2juuXtG/
   heM0yiDM7aR7Tgur/XYrFMLQSN+JuCsCc+rmF3ybCst7bkVxQM/Xochj+
   F6uEZsm5Zk8NehnZ4eXt5XMzBTI6RMyPkywiMDNjEWnnDvXAhvvtPeQxK
   fNZhbI9IB4pjRTqsrH1tzz6B6I7Iot7wIrnr6N3oP8f1uh1vLIKBN0F7l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237566125"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237566125"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 10:35:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="538757429"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 10:35:13 -0800
Date: Mon, 14 Feb 2022 10:35:13 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
cc: Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: FAILED: patch "[PATCH] selftests: mptcp: add missing join check"
 failed to apply to 5.16-stable tree (fwd)
Message-ID: <2591cf5c-549-747e-7685-edf53cf0a046@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


Paolo, Matthieu - I'm not currently planning to backport this but if you 
think it's worthwhile, let me know.

-Mat


---------- Forwarded message ----------
Date: Sun, 13 Feb 2022 23:24:18
From: gregkh
Subject: FAILED: patch "[PATCH] selftests: mptcp: add missing join check" failed
      to apply to 5.16-stable tree


The patch below does not apply to the 5.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

>From 857898eb4b28daf3faca3ae334c78b2bb141475e Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 9 Feb 2022 17:25:07 -0800
Subject: [PATCH] selftests: mptcp: add missing join check

This function also writes the name of the test with its ID, making clear
a new test has been executed.

Without that, the ADD_ADDR results from this test was appended at the
end of the previous test causing confusions. Especially when the second
test was failing, we had:

   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   add[ ok ] - echo  [ ok ]
                                   add[fail] got 2 ADD_ADDR[s] expected 3

In fact, this 17th test was OK but not the 18th one.

Now we have:

   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   add[ ok ] - echo  [ ok ]
   18 signal addresses race test   syn[fail] got 2 JOIN[s] syn expected 3
    - synack[fail] got 2 JOIN[s] synack expected
    - ack[fail] got 2 JOIN[s] ack expected 3
                                   add[fail] got 2 ADD_ADDR[s] expected 3

Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8bdbec0cf69..c0801df15f54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1159,6 +1159,7 @@ signal_address_tests()
  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
  	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal addresses race test" 3 3 3

  	# the server will not signal the address terminating
  	# the MPC subflow

