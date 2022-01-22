Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE2173
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 09:32:02 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a8so6745199ejc.8
        for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 01:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ7V4tnlQ+3X+C6bzIkrGn+AhGVRhvHGe/gMLAVxRm8=;
        b=N0ht63c+GceSuxsIvh9ELla2g4T6+3j6FNvP4ssXCg504V0y9hnBzKgtn7tSdz44QH
         DYZnse1QEiYRZPuOa/mcuEjLs2/s+KkyhdFfxaT4PN9/VplTJB1PwlrOGvDD4f1dXE1L
         PIDo0DcPzfTpB7F4zF8ie4u2dCNMjPE27JCx9R7H0l/n/nC2NIFecwNVGVnud8Oxv8Ki
         We5ag7ibyNryETBwOD0LIE3ttSerxom9OnxTLLQ7snDDWHnI+CF8R5KPSi+rq/J5vFva
         FYl+W9zmpcbokg8wk7CZMitOg8sgaJIlCpBJTy4BWipNB0i7FSH6B+tBgZz4lVlV+UPt
         q5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ7V4tnlQ+3X+C6bzIkrGn+AhGVRhvHGe/gMLAVxRm8=;
        b=eSt+msvwSMWhoDAPc6Z5KbSwUdExtSyIiNohEwIb9i2XTbVKyoR6dyEp+47hG2O7hZ
         nJsBlZtT9R0neHw5zVeHjhhkBqVrjeEsx5Ch+mdMx+JC2fnoOLaXpZokjyb399Ztwn8q
         oaJuJk1J9sDWZ3UHHfGj3ntDnxEFSFzJ9iuFciU3Pd73vSvIvHpwW14YLP7EMyJbFeXX
         IC9cDlPcMzlqKsTiQi2OQbI7eGI2Z3uW3UCcAhLph6qFr6xyBPd3UQcjyED89IIZMXYs
         VzUnL9o+1fjGBjKQ/sa4HcIiRuw/Bl3sBihgd2BUuAOQZLqbY6MvDlzrt+mwkTG1fyGA
         1ITw==
X-Gm-Message-State: AOAM533wHbxFoOxctagJLRmFw5KxkNBEXmWrXU+aULTSoLq2nUFAQCnQ
	mT4e3mieqryEs8ML5T3v5VYRoLej1Fi7ZnrT
X-Google-Smtp-Source: ABdhPJwYzS8Z2ZoJSUl48IhZdMjPwhL0OLgfKQMrMhM2xAW7TODVjiqAejYNI8NYIjgPWPr8bmZcjw==
X-Received: by 2002:a17:907:e9f:: with SMTP id ho31mr6409633ejc.187.1642843920369;
        Sat, 22 Jan 2022 01:32:00 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e28sm2776994ejm.94.2022.01.22.01.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:32:00 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 0/2] selftests: avoid confusions around 'signal invalid addresses'
Date: Sat, 22 Jan 2022 10:31:33 +0100
Message-Id: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Paolo, we were trying to understand why one test was failing, see:

https://github.com/multipath-tcp/mptcp_net-next/issues/254

Paolo noticed that even if the CI was reporting this:

  17 signal invalid addresses             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                          add[ ok ] - echo  [ ok ]
                                          add[fail] got 2 ADD_ADDR[s] expected 3

The issue here was not with the 17th test but with the next one. This patch can
be sent to -net.

While at it, we can also fully remove mptcp_parse_option() from mptcp.h. Not
sure this patch needs to be sent to -net but it should not be rejected from
there :)

Matthieu Baerts (2):
  mptcp: mptcp_parse_option is no longer exported
  selftests: mptcp: add missing join check

 include/net/mptcp.h                             | 6 ------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.33.1

