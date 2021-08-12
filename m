Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322372
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 03:38:03 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so8585077pjb.0
        for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfR2ZRInwbC+VglQTXwPWR0vsoUyl6BymUNuFOsoqLg=;
        b=gh34TV/C9XdGZeULtsxTjTEwNm0IPtfPvSfzPzRapOdoF+4Z5RiD2oSMvuyqmFFiLt
         jVUcmKXBv/v7o8qGPuR8f6uvnOhuOnZS+Z86L1+pa1JPzkS5vDN+j2qMSfZSelq2K8q+
         5LxvG79tqS5is/ZSHx24M1mg/2kvE0BwBykTa1rhHE6XKwFDo1ikXcNYAGGWgb0EfOH5
         mNYxnduQrLooCAPwZUZp9ud9boAzlCxtmvSlkVmYQh5XqLOUtXDsZBrXevUvLNnfbRvs
         BxcF7tx8vUfToxhnh0G4FNAI011l2OH7DzH9fpA92gcnVFuvyw3QgoAt9GL+2HJGVtsA
         aOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfR2ZRInwbC+VglQTXwPWR0vsoUyl6BymUNuFOsoqLg=;
        b=qEkdQCT3maTO6CoNOipNtgrSzZVDNiJKy5hhLLPE2LqyIG79UEzTOUn03yjh1FY3ry
         XltH1sWr/yYOymBmn8qzYrZV0oQT3ZpwBCB+6YisiZ7UmmN6ltcBHnhYQKBWa0iNGiu2
         cnJIxTxjZshRHDvbUQZvxrFJ4rAVuz3Sgu7ivApmtlAuRDCeeehnaNLrjgNMyN0LKSQD
         /tj9jeeuRq/dRnBT5pXH2wcqiHffsz/soi3jQ1cake7YzQjvrvvfu/uwDY+OzIK3t6Ag
         y9eBOSxzLgpuePoo+n7UoH/leOLlejvRRHhKGts04BZt4JC0eEelEHxKm5bvagWAHR1a
         HXaA==
X-Gm-Message-State: AOAM532kfZK3xnQnWQoKBFVLuqKBLQb7FM0E4JIOkI39QsBkxbk8zyq/
	aCl80nb9WXAuRLerNnqhS8laBzR14VU=
X-Google-Smtp-Source: ABdhPJx6G2J0WXxxC0pP4XtjNw0dnFDeVWAfHDlV+/JWEThtsn90X01MRZc+el2d2fnzi7koDjUahA==
X-Received: by 2002:a65:450c:: with SMTP id n12mr1909824pgq.316.1628739482909;
        Wed, 11 Aug 2021 20:38:02 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id e3sm1100853pfi.189.2021.08.11.20.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 20:38:02 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH mptcp-next] mptcp: free entry when release_work allocation fails
Date: Thu, 12 Aug 2021 11:37:57 +0800
Message-Id: <cba51616ec99f106c50dd7b0560450812adcd581.1628739395.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch fixed this syzkaller error:

 BUG: memory leak
 unreferenced object 0xffff88810680ea00 (size 64):
   comm "syz-executor.6", pid 6191, jiffies 4295756280 (age 24.138s)
   hex dump (first 32 bytes):
     58 75 7d 3c 80 88 ff ff 22 01 00 00 00 00 ad de  Xu}<....".......
     01 00 02 00 00 00 00 00 ac 1e 00 07 00 00 00 00  ................
   backtrace:
     [<0000000072a9f72a>] kmalloc include/linux/slab.h:591 [inline]
     [<0000000072a9f72a>] mptcp_nl_cmd_add_addr+0x287/0x9f0 net/mptcp/pm_netlink.c:1170
     [<00000000f6e931bf>] genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/netlink/genetlink.c:731
     [<00000000f1504a2c>] genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
     [<00000000f1504a2c>] genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c:792
     [<0000000097e76f6a>] netlink_rcv_skb+0x148/0x430 net/netlink/af_netlink.c:2504
     [<00000000ceefa2b8>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
     [<000000008ff91aec>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
     [<000000008ff91aec>] netlink_unicast+0x537/0x750 net/netlink/af_netlink.c:1340
     [<0000000041682c35>] netlink_sendmsg+0x846/0xd80 net/netlink/af_netlink.c:1929
     [<00000000df3aa8e7>] sock_sendmsg_nosec net/socket.c:704 [inline]
     [<00000000df3aa8e7>] sock_sendmsg+0x14e/0x190 net/socket.c:724
     [<000000002154c54c>] ____sys_sendmsg+0x709/0x870 net/socket.c:2403
     [<000000001aab01d7>] ___sys_sendmsg+0xff/0x170 net/socket.c:2457
     [<00000000fa3b1446>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
     [<00000000db2ee9c7>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
     [<00000000db2ee9c7>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
     [<000000005873517d>] entry_SYSCALL_64_after_hwframe+0x44/0xae

 BUG: leak checking failed

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/223
Fixes: 1729cf186d8a5 (mptcp: create the listening socket for new port)
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 371607dc6ff7..184a75e1c8ec 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1324,6 +1324,8 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
 		INIT_RCU_WORK(&w->rwork, mptcp_pm_release_addr_entry);
 		w->entry = entry;
 		queue_rcu_work(system_wq, &w->rwork);
+	} else {
+		kfree(entry);
 	}
 }
 
-- 
2.31.1

