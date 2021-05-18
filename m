Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388962FBF
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 10:05:18 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id v13so4798153ple.9
        for <mptcp@lists.linux.dev>; Tue, 18 May 2021 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQBlYbUcAMsEeUXzSteRJVB604pmAWj1/RqsplJ4toA=;
        b=k8VsH2RzXwfx9eCifnggsln+ChjkZBhgYhqAACE4M2bRghC57WcCcuieVuseOIBcrk
         +6/iz6AW/FO46Hr179vig4E1akTn5wp4L36iXNTJqHkYd0PDcJGSgDVElFm9VXh0dJAz
         mHYF+VIPZKSNDcHKuN6AzwojBzI8lpgApAN8c7Re7oRriDtLdyXEp0JPOkf3Nca0VjWU
         lie98kIonFmMJf3tNG1UNfQC0+IdrBs2QlJb1FyqqAeLnytnJhvEpTeLESSXJpjWjgtW
         OvDkPynAcNanXPTgAFhOjUXe9Rc6a5JH8TiFg4PVC4TuqI45mJj0qF5hhJYj9PWksKHm
         TYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQBlYbUcAMsEeUXzSteRJVB604pmAWj1/RqsplJ4toA=;
        b=MaAmcaTfW9rwxk9v0ZRdaWj98ehuvHxxRZkkdF0oBeHeRFYLbgE6XCKpupHysK+URR
         pkeTHOu3vDnK5dd+rTte3ueRFTopQNYc+6E/BCyY8gGObP4CmTagNIPk9vbBceAzNYvz
         fC7ux6i/+Fh1n8bIBlWBsIB4kvNN6Jd2v2XPMBzX7rB32tq4u4t2atHkgSg1VOEoCk+e
         WZwSaHJGz7ciDcHprvVhgtXkKS0ufY7CKiQx7Cn4jSM8lFyjlsKSMFq0WHNcAgctqOGU
         33KIJ/Pvra1Y80vQtl01w//fOrsPYRDDD1b35k/msKNjqQdfQ7H4eu4FTZ/udvAboAGv
         Jgbw==
X-Gm-Message-State: AOAM531yH3rBivoMS0tBM90iJ+y409jVcmn6GMcRDQdUzJx8/5kAciLc
	ZphHXcSEfkxhIr58AsXf2dv0aeZ4xlE=
X-Google-Smtp-Source: ABdhPJy0LfNBL37g+uJuIOuAPi0b/mIozvur63VXG6XwLI/q/mw05yBRtEkiG6Q2rumbY9dw89W+PQ==
X-Received: by 2002:a17:903:3106:b029:ee:fa93:9546 with SMTP id w6-20020a1709033106b02900eefa939546mr3761154plc.23.1621332317735;
        Tue, 18 May 2021 03:05:17 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i123sm12316276pfc.53.2021.05.18.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:05:17 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add deny_join_id0 in mptcp_options_received"
Date: Tue, 18 May 2021 18:05:13 +0800
Message-Id: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please add this line to the commit log:

'''
In mptcp_finish_join, add the incomming join address check too.
'''

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c725e8f02533..5cebecc838ca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3116,7 +3116,8 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (!msk->pm.server_side)
 		goto out;
 
-	if (!mptcp_pm_allow_new_subflow(msk)) {
+	if (!mptcp_pm_allow_new_subflow(msk) ||
+	    (READ_ONCE(msk->pm.remote_deny_join_id0) && !subflow->remote_id)) {
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;
 	}
-- 
2.31.1

