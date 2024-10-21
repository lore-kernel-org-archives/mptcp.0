Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D181799F;
	Mon, 21 Oct 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500426; cv=none; b=QxG2CXPSI3l7R7k/qPpXGxqUTnffh/3npqJJjIJ5twgkqyrtgw4swfUdqN4yQ7XtL9E8J//goLbtNYr90jtZnf8SPLmgnn8jTFuuCSCyDf3Be8BW1DxEFKHqov4poQ5EYT0589gPHS/WnIxPuAytdr/OlujQM3D8M2lDVf5Vx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500426; c=relaxed/simple;
	bh=0vajJmHGJpbRjmbMFiAdcPWo5yQXY8sQ7GZPk0g8fRY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=TwzrFHW81hCTznUIk/BPICkDqr4eZVg/i2lDL2UMQltj6kM2jnfamgJaZJoKDDCMmxavj4iA3CjGIvcfsG+BmsqXFoe6sECIjHoT8lh+QGO6inRMKHms8EqR7btdFnGKuJdbPAiPW7nhjGLeLUcv9BjtElANzufEgqjW2A9dATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qPqAxrwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qPqAxrwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F40C4CEC3;
	Mon, 21 Oct 2024 08:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729500426;
	bh=0vajJmHGJpbRjmbMFiAdcPWo5yQXY8sQ7GZPk0g8fRY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=qPqAxrwpaOm5e31n/JfePobAgTo9DWH9HnyiV1Im7Eb1KzZcL46+UGApnthY2Uvzj
	 Pk5yp4j63kY2VpWWw0DoZT5tDWSn0u2SU+4cPgX7I7+39WUjoDtVbp7GvsLVOzHbGY
	 DVzYBqhSWMQIUmRKpG/aKD5P/2XnNtS4ZtSdMcrQ=
Subject: Patch "selftests: mptcp: remove duplicated variables" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 10:46:56 +0200
In-Reply-To: <20241018155734.2548697-10-matttbe@kernel.org>
Message-ID: <2024102154-sworn-trout-165e@gregkh>
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

    selftests: mptcp: remove duplicated variables

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-remove-duplicated-variables.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-86860-greg=kroah.com@vger.kernel.org Fri Oct 18 17:57:54 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Oct 2024 17:57:39 +0200
Subject: selftests: mptcp: remove duplicated variables
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org
Message-ID: <20241018155734.2548697-10-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

A few week ago, there were some backport issues in MPTCP selftests,
because some patches have been applied twice, but with versions handling
conflicts differently [1].

Patches fixing these issues have been sent [2] and applied, but it looks
like quilt was still confused with the removal of some patches, and
commit a417ef47a665 ("selftests: mptcp: join: validate event numbers")
duplicated some variables, not present in the original patch [3].

Anyway, Bash was complaining, but that was not causing any tests to
fail. Also, that's easy to fix by simply removing the duplicated ones.

Link: https://lore.kernel.org/fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org [1]
Link: https://lore.kernel.org/20240905144306.1192409-5-matttbe@kernel.org [2]
Link: https://lore.kernel.org/20240905144306.1192409-7-matttbe@kernel.org [3]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh |   11 -----------
 1 file changed, 11 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -9,17 +9,6 @@ readonly KSFT_SKIP=4
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 # These variables are used in some selftests, read-only
-declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
-declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
-declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
-declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
-declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
-declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
-
-declare -rx MPTCP_LIB_AF_INET=2
-declare -rx MPTCP_LIB_AF_INET6=10
-
-# These variables are used in some selftests, read-only
 declare -rx MPTCP_LIB_EVENT_CREATED=1           # MPTCP_EVENT_CREATED
 declare -rx MPTCP_LIB_EVENT_ESTABLISHED=2       # MPTCP_EVENT_ESTABLISHED
 declare -rx MPTCP_LIB_EVENT_CLOSED=3            # MPTCP_EVENT_CLOSED


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-join-change-capture-checksum-as-bool.patch
queue-6.6/selftests-mptcp-join-test-for-prohibited-mpc-to-port-based-endp.patch
queue-6.6/tcp-fix-mptcp-dss-corruption-due-to-large-pmtu-xmit.patch
queue-6.6/mptcp-pm-fix-uaf-read-in-mptcp_pm_nl_rm_addr_or_subflow.patch
queue-6.6/selftests-mptcp-remove-duplicated-variables.patch
queue-6.6/mptcp-prevent-mpc-handshake-on-port-based-signal-endpoints.patch
