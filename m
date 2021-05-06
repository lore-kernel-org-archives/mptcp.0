Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131272
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 06:39:58 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id md17so2807701pjb.0
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQbeOXQYDeAaojuYYOkhVLQ/Uh6LB+/iNLUmIBnRRTo=;
        b=UJJNzQitbQQLYZIExvAPt7fEHC1kIktgUF27ZOvYGgaLT3FbkNbeO9f/kNOnoPJihm
         ZJD8qxrxelfeyFu4UPm3kHmFU4wBQlh/3+4OOt9WWbuat1fZZbEGzdCZIt7llKDNdFX9
         YqXlCPpxKvbcF7ovn9FIrBHyS1Xbw3D1afIKjz32H8LN5hSKLAffGTBwYQtImsNx39Q2
         ZMkvbJ/fP37kOycZBAovH++EJ+UmT+FmcoItd5hZLRn5wM9xKIk/iL/e8CNVfwmYenJc
         J8X5/u+rp3IOVN8l7oXLtqQhrANquird2UKNI4rFH1mV7zr7tg/ndSHLdTnyjIbVLyu7
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQbeOXQYDeAaojuYYOkhVLQ/Uh6LB+/iNLUmIBnRRTo=;
        b=IO9w5Yu+yP7LGk9nZ9vCxdhotO2td8AiMHfc/o+u4W8udd4xDbuiqZGq0JujoNh+UV
         WZnalb6ydqCo6vJFZ6VEwFRrYNAqv6VOZcnEn8+Vzf4SElC74AAGTw6m/HdoGQHarl8n
         ipO2NRRTlhL5cwkoAHnh1JvNwgnhUexQVuwN2J1pqkgAfz8uVU3Rg8vU32TL4qrRsLkz
         fjBLV03kYpsrMKDPD+nqe32YaNDgGBEy6QzQXdfz+nwLszamVT+qADk4GPhaE98B8sek
         yIDMybCxHHyxptb7IfF/z9dS2j12tJcMaxy8kkulR0hXuevxlisCcmYqtirUtvomHbom
         AMBA==
X-Gm-Message-State: AOAM530/KMgvtCOqPM8pYnLmoTPLtwdf9ISC5ZdE1vNKUwad+S0FxHxU
	u1j3mnAQuVN04ZbfEZ9WTUTCbZstrLI=
X-Google-Smtp-Source: ABdhPJySCfG77E+FL6lmZHQKj4jBelyQlNP9pk069l6xl7AExV/d91Vm79+BMZZjcbyK5nSkzf/fHg==
X-Received: by 2002:a17:90a:f3d3:: with SMTP id ha19mr2866960pjb.166.1620283198038;
        Wed, 05 May 2021 23:39:58 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id p36sm990599pgm.74.2021.05.05.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:39:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 0/3] MP_FAIL support
Date: Thu,  6 May 2021 14:39:50 +0800
Message-Id: <cover.1620282929.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply:	export/20210504T064955 +
	"data checksum support" +
	"data checksum support cleanups" +
	"add MP_CAPABLE 'C' flag"

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52

Geliang Tang (3):
  mptcp: MP_FAIL suboption sending
  mptcp: MP_FAIL suboption receiving
  mptcp: send out MP_FAIL when data checksum fail

 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 62 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/pm.c       | 17 ++++++++++++
 net/mptcp/protocol.h |  7 +++++
 net/mptcp/subflow.c  |  2 ++
 5 files changed, 88 insertions(+), 1 deletion(-)

-- 
2.31.1

