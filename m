Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3C367B9E
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120543; cv=pass; b=YtQ7rqKc6t/oSYDDjiaC3lxYxus80xSHUqPmb1q5r2uYd1nMbxXmZjY6s5QdeUjONLu29xfwohk1vGzLrhfgEiCQ7k94yz1zquVo+ZginAlD8BEM4STfUZD7CuBCNidXdTNlvXm23YvfnjCEg5pWMdF4bJWWO+wr31EDjIn40LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120543; c=relaxed/simple;
	bh=t6TL6e/gceFvw1DM7eiUKsKa8q86AYozuJ8qq7FTNQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cb7YYzv4wOg/iMNhSgrMiS0sWWTX9tMysjdhgexz76Ll6bqkLjR/7VoVHlouIyrT2TAruSEDeXBKmG2ODYkMzpaJCm1SWAFpR46JJibzkhQgKGnzzdZtQjyGh8NaM1w+6qNTHL0bnifvSJ9GGOD/gF8vhq2xrumqZmn/pub3He0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=gU/vk28k reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="gU/vk28k"
ARC-Seal: i=1; a=rsa-sha256; t=1782120533; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=heE1SYOCA6sL/4xGEoaQcaBNdhKn3TOG9MiMkLmkdef1rzpRQt7qkgBv+VLfnBjspPJl8aG8hukMDpxzAyIBh8bzFO7Z8Qcdtre4r3Fl1//ZStMUx8bp+5pNK0D5143KicjcILsS4z0/pY5+zjRx7b7tyrteMZwCharX0coCha8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782120533; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yLadk7aHIgI4+pBasSi/++A916Z0JC5snlQQY9ZmYh0=; 
	b=le46tAcFv+OcMKk5HJGHFG6/idji3z4rSPGxBxe4tkqsDuo5S/EEsEk/ly7S+t7RQdMt/b/FW7uK0Czc9taxKM81llMviC2po1/3NkBW7Ra2qs8RXvKZpxizfP1toxe/llWomhLMMgeHH+wS7SHwVkgBVNmh15DiTRTqDmp9w7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782120533;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yLadk7aHIgI4+pBasSi/++A916Z0JC5snlQQY9ZmYh0=;
	b=gU/vk28kofk7P/GUU2e7gybxOCbRi2vZFOmj9oZXiO6cD4TqbTUOJKWoJ+nFyfau
	WOz3WKvl+/J8mVTyC/vAw619cgu6pHqVzDGOB/qdovyGK84U12Osd8LO2da4gNClhkt
	WrL5TFVm7+nPmO/OudkzhvXrLmMUsbWVFVBRjLwU=
Received: by mx.zohomail.com with SMTPS id 1782120530887703.2607859095817;
	Mon, 22 Jun 2026 02:28:50 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	cuitao@kylinos.cn,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net v4 0/2] mptcp: pm: fix stale ADD_ADDR entry on id 0 removal
Date: Mon, 22 Jun 2026 14:58:34 +0530
Message-ID: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Tao, Matt,

Thank you Tao for identifying the port mismatch in v3 and providing a
deterministic reproducer — both are incorporated in this series.

The problem with v3: mptcp_remove_anno_list_by_saddr() compares
addresses with use_port=true. Signal endpoints added without an
explicit port are stored in the anno_list with port 0, but msk_local
carries the connection's actual local port. So the v3 lookup always
missed the stale entry, making the patch a no-op. Confirmed with a
temporary printk showing msk_local.port=5000 and announced=0 on v3,
and announced=1 after clearing the port.

This series:

Patch 1 fixes mptcp_nl_remove_id_zero_address() to tear down the
pending ADD_ADDR symmetrically with the non-zero id path: copy
msk_local, clear the port, call mptcp_remove_anno_list_by_saddr(),
and decrement add_addr_signaled if announced.

Patch 2 adds the regression test based on Tao's reproducer. Verified:
  - unpatched kernel: WARNING: net/mptcp/pm fires, test reports FAIL
  - patched kernel:   no WARNING, test reports PASS

Tested with mptcp/mptcp-upstream-virtme-docker auto-normal. All
existing selftests pass (packetdrill_add_addr failure is pre-existing
and unrelated to this series).

Kalpan Jani (2):
  mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
  selftests: mptcp: add regression test for stale ADD_ADDR on id 0
    removal

 net/mptcp/pm_kernel.c                         |  8 ++
 .../net/mptcp/mptcp_id0_stale_anno.sh         | 85 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_id0_stale_anno.sh

-- 
2.43.0

