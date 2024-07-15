Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36441891B2;
	Mon, 15 Jul 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045468; cv=none; b=Qkl273zKnfwzO/fXdSv9Howw84CTTag3eWhdhA1fsxa0tA9fKbBd15UCA+otU8bmR4djfgoRxvMa/oetoYpRKVbvViJdTbApn9hmIlUpScVy3VounXlu94ji64obAnQ0bV2YfOJtCiTXyrOP4XupdxlGAtRafs4r0Kcjk1VvbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045468; c=relaxed/simple;
	bh=OLla2ot6MVPGEzXdjETLGzGUbb60Y7lf57KZvicLz1I=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=UzRCG4r8jMvXXlrHegZn/EI9LVQYQWWaBD22fSib8JQi32ZunNhMQslPgQd30qdmc57m8BfUJ0i+cgJ5rASRs0fTARtnhdo8CsYtLJrTSDdyTiZlWHU3dHVMzz1eExFhhlKMvfsEAuvTo2uaf5qlZxixNB07bmb1zqd0746glNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yXbfmtS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yXbfmtS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181ECC32782;
	Mon, 15 Jul 2024 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721045468;
	bh=OLla2ot6MVPGEzXdjETLGzGUbb60Y7lf57KZvicLz1I=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=yXbfmtS6ij6QYfl4lWR8YyFlX7pO4NIqoc3k28NPDPoI8bs6Ln+DEKD2Sv1/d20pf
	 +WJczwkAFqcQk901zfIpviysORIY0pd8BhMTMhvUbIHJ35paGueYJcUsW+8vFP9/+E
	 l3RIac46bfydGITUOsTlyhOZ+8SCVL78Amwp06bw=
Subject: Patch "[PATCH] selftests/net: fix gro.c compilation failure due to non-existent opt_ipproto_off" has been added to the 6.6-stable tree
To: 0x7f454c46@gmail.com,8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com,afaerber@suse.de,alexander@mihalicyn.com,bigeasy@linutronix.de,bpoirier@nvidia.com,davem@davemloft.net,dev@openvswitch.org,edumazet@google.com,geliang@kernel.org,gregkh@linuxfoundation.org,herbert@gondor.apana.org.au,idosch@nvidia.com,ignat@cloudflare.com,jhubbard@nvidia.com,kuba@kernel.org,linux-actions@lists.infradead.org,linux-arm-kernel@lists.infradead.org,liuhangbin@gmail.com,llvm@lists.linux.dev,manivannan.sadhasivam@linaro.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,petrm@nvidia.com,pshelar@ovn.org,razor@blackwall.org,shuah@kernel.org,steffen.klassert@secunet.com,willemdebruijn.kernel@gmail.com,zhujun2@cmss.chinamobile.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 14:11:05 +0200
In-Reply-To: <20240712235150.99175-1-jhubbard@nvidia.com>
Message-ID: <2024071505-recycler-proclaim-10c1@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    [PATCH] selftests/net: fix gro.c compilation failure due to non-existent opt_ipproto_off

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-net-fix-gro.c-compilation-failure-due-to-non-existent-opt_ipproto_off.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From jhubbard@nvidia.com  Mon Jul 15 14:10:26 2024
From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 12 Jul 2024 16:51:50 -0700
Subject: [PATCH] selftests/net: fix gro.c compilation failure due to non-existent opt_ipproto_off
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Shuah Khan" <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Steffen Klassert" <steffen.klassert@secunet.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Andreas Färber" <afaerber@suse.de>, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>, "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Pravin B Shelar" <pshelar@ovn.org>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Alexander Mikhalitsyn" <alexander@mihalicyn.com>, zhujun2 <zhujun2@cmss.chinamobile.com>, "Petr Machata" <petrm@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>, "Hangbin Liu" <liuhangbin@gmail.com>, "Nikolay Aleksandrov" <razor@blackwall.org>, "Benjamin Poirier" <bpoirier@nvidia.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Dmitry Safonov" <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, mptcp@lists.linux.dev, dev@openvswitch.org, linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, "John Hubbard" <jhubbard@nvidia.com>, stable@vger.kernel.org, "Ignat Korchagin" <ignat@cloudflare.com>
Message-ID: <20240712235150.99175-1-jhubbard@nvidia.com>

From: John Hubbard <jhubbard@nvidia.com>

Linux 6.6 does not have an opt_ipproto_off variable in gro.c at all (it
was added in later kernel versions), so attempting to initialize one
breaks the build.

Fixes: c80d53c484e8 ("selftests/net: fix uninitialized variables")
Cc: <stable@vger.kernel.org> # 6.6
Reported-by: Ignat Korchagin <ignat@cloudflare.com>
Closes: https://lore.kernel.org/all/8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com/#t
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/gro.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -113,9 +113,6 @@ static void setup_sock_filter(int fd)
 		next_off = offsetof(struct ipv6hdr, nexthdr);
 	ipproto_off = ETH_HLEN + next_off;
 
-	/* Overridden later if exthdrs are used: */
-	opt_ipproto_off = ipproto_off;
-
 	if (strcmp(testname, "ip") == 0) {
 		if (proto == PF_INET)
 			optlen = sizeof(struct ip_timestamp);


Patches currently in stable-queue which might be from jhubbard@nvidia.com are

queue-6.6/selftests-net-fix-gro.c-compilation-failure-due-to-non-existent-opt_ipproto_off.patch
