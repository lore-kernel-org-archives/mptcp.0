Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5779DF;
	Mon,  4 Mar 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540791; cv=none; b=Bc2qvE7FYBA9+jiVSDwnppuIxl91hWOXoNY9/K8STUG2kxfxiogUI9z45274cwb0cwLuJMFbAYEtfLIJ2EJmV/1+GwvL2vl39MXuOtJOSadUGQKFofov4J0In9uopQuPku87kro2Iw0OWqGDMhm0k1XEsK0TONkk4tFb1W6xnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540791; c=relaxed/simple;
	bh=HUqaxE2tl+KpQmdvdoCilSNj4dah+7oRp1WZO+mMU/g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=cW0Q+tUvJE1/7NxkwtAW9POjG/IMoAl0c5Mz2h4AKqZ78P6Tf/SKBlPD9NKLPx9bQjqjRgrynL3R941Dp0uvLtRCVed0tH2IykK5cywW6w/ZfZ/CiCf/D+EWW7CCfKZ2jTV55jsXZi5GwKPstv7kCw/OQKglMtfPiJiEmIFIzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vz7ap+fK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vz7ap+fK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A88C433F1;
	Mon,  4 Mar 2024 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540791;
	bh=HUqaxE2tl+KpQmdvdoCilSNj4dah+7oRp1WZO+mMU/g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Vz7ap+fK2zNofpOMQZ2ThkfaqpIYjPMBtnYYmVQqecjgZp5pTm8FKVFCgevThdCQr
	 cpf8XQvYIaAIa4Da7bubosfPaDSCcYl+97N7xYEpkdLhp0ie0McmIYbX/9Q+0rmzp4
	 XdAHyziuC+9qNyyLaM/SqlQuLNrfDP+66Qpqp4Bs=
Subject: Patch "selftests: mptcp: add missing kconfig for NF Filter" has been added to the 5.15-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:26:09 +0100
In-Reply-To: <20240228173435.258891-2-matttbe@kernel.org>
Message-ID: <2024030409-plot-stiffen-7531@gregkh>
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

    selftests: mptcp: add missing kconfig for NF Filter

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25405-greg=kroah.com@vger.kernel.org Wed Feb 28 18:35:15 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:34:36 +0100
Subject: selftests: mptcp: add missing kconfig for NF Filter
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240228173435.258891-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 3645c844902bd4e173d6704fc2a37e8746904d67 upstream.

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table.

It is then required to have IP_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -17,3 +17,4 @@ CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
+CONFIG_IP_NF_FILTER=m


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
queue-5.15/mptcp-add-needs_id-for-netlink-appending-addr.patch
queue-5.15/mptcp-rename-timer-related-helper-to-less-confusing-names.patch
queue-5.15/mptcp-process-pending-subflow-error-on-close.patch
queue-5.15/mptcp-clean-up-harmless-false-expressions.patch
queue-5.15/mptcp-move-__mptcp_error_report-in-protocol.c.patch
