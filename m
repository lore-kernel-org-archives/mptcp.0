Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42079DF;
	Mon,  4 Mar 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540789; cv=none; b=dUGktjrh07Z3Gu9ifjsfYcqPYllhCzcSfxtj+fUnFvd1goiW1cz9R51UrhpYh7Q1Q7Xceu4rkh2AHC8Z21D+gtrnIV/0443YtTLy84ubNax+658Q5wOwYrpTPuV3ttaHmQQlRUBuh6LGOkbw3YvmYIQraS/y9I6I3vvkxLWULFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540789; c=relaxed/simple;
	bh=XdQZfCdEZQwNDzjHxxLScd1/I6Ugr+4gOF3ggINPAEY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=hilSl58ut6vxSc0SWEi3twnSj5wNP63fmmf+W2/+ndoZbzR1K956avz3BjcJP/MphsOnOdji0JJCus8eX1SbwaZKmucf4TxSgJczdgg8iMFbEYrsi0acotMhpmLWZF6Q04w9eefz0ASB6N8f5W3G6H/cv20s6VPsNfLGNWL5tuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z1rGy/vo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z1rGy/vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07465C433C7;
	Mon,  4 Mar 2024 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540788;
	bh=XdQZfCdEZQwNDzjHxxLScd1/I6Ugr+4gOF3ggINPAEY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Z1rGy/vo5/CGaZpPJfrqRJoSviR2qHyLN8Re/iuIAi91tgvWV5MF2hE4qMJlAohRr
	 s83XloJLDtKb1Dz8hcs/eE1uPQw434fI/5U2A017TUUWNf1gBSZmtYNwKUPmROgMIZ
	 OxvGydaGASY8oIi2Zq1qrx3cErSE9pm0L6aKtjgc=
Subject: Patch "selftests: mptcp: add missing kconfig for NF Filter in v6" has been added to the 5.15-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:26:09 +0100
In-Reply-To: <20240228173522.259824-2-matttbe@kernel.org>
Message-ID: <2024030409-smasher-expire-22d4@gregkh>
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

    selftests: mptcp: add missing kconfig for NF Filter in v6

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25406-greg=kroah.com@vger.kernel.org Wed Feb 28 18:35:51 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:35:23 +0100
Subject: selftests: mptcp: add missing kconfig for NF Filter in v6
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240228173522.259824-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 8c86fad2cecdc6bf7283ecd298b4d0555bd8b8aa upstream.

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table for IPv6.

It is then required to have IP6_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-3-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -18,3 +18,4 @@ CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_IP_NF_FILTER=m
+CONFIG_IP6_NF_FILTER=m


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
queue-5.15/mptcp-add-needs_id-for-netlink-appending-addr.patch
queue-5.15/mptcp-rename-timer-related-helper-to-less-confusing-names.patch
queue-5.15/mptcp-process-pending-subflow-error-on-close.patch
queue-5.15/mptcp-clean-up-harmless-false-expressions.patch
queue-5.15/mptcp-move-__mptcp_error_report-in-protocol.c.patch
