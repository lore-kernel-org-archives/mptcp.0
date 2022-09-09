Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9C622
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 05:49:46 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id b144so679643pfb.7
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zfjTtsrORODWPAnoElqcq+UGRe4yX6WpO1UZKoa9Zh4=;
        b=aYpXC3cEGNIzQP7//sJBpe2NGNLPGBiFx4diwUqF3fhOgZt2dOuSV2arlYu85CeKQb
         jhZNuVPuNGKOA9NGo3uuHj01CaVNmndfCVmCnHFn4GDHyq8tmNuz1H77nWMgGk+DDmiR
         LfdxF1ZrdtEYBST7YRaXCoL5zXG3O+zodz/C9UB47pR/JZmjz/ekjBitCo//Ogw3vmhh
         id+cIllFYOdOHakkICwGjXRJxupfLkngYF3Jymw72l/uYFtUt4jEKFubCUWf123L++6q
         ZBI6P8TCQ3S611TyEiMuKkiKiW3BrMpdyKm21l3nFOy73ZXdxXvVmu/6MXHozmU2OX7u
         LEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zfjTtsrORODWPAnoElqcq+UGRe4yX6WpO1UZKoa9Zh4=;
        b=Y/Nszj2/1J7xYaShXXjii1nMp2zjhiTbMvTANoEvksm8ZRy71JfNELAdmbDTpcBtZ0
         ih0LhEJrUjCrXCImqt9Od2M6tMkwIYbUmPozveSvtnKvCFBMlfcjgVQJ0S2hhrjAa8wF
         vq1ePzbg9Jq4op7ghE3XuVrnMkxTUn0iCPcxIVyNJa2A4zaOWsl9q/VZP19IviiwhPRz
         TNu3pAe22R5gV7nxJ/7GUQtcfSzZI4yCFQu3Qb+e97ZwE30qMo9FvwOu2xpdj5fdF01d
         csrtau5hyhBatTdjrKz34DMluUOsvGTQt29a0rHmCqHWJpsc/Htu9yKZ2brYIZwrjBLW
         RQ2A==
X-Gm-Message-State: ACgBeo1dQvhzLxfjhmfHO2ye0N99dvz7u+pmk3ekWZt7F5Zz2cNs6weD
	8iZjPUTz/cIu2Nb47geLS9M=
X-Google-Smtp-Source: AA6agR7vQhzjCLQ8ssV38+JRLA/gvaE90/y/airIpb154UQ0quw+jq9sBFUZne6G08YNqhIi5Fi8Sw==
X-Received: by 2002:a65:4941:0:b0:42a:8c1b:6b6c with SMTP id q1-20020a654941000000b0042a8c1b6b6cmr10862951pgs.375.1662702586475;
        Thu, 08 Sep 2022 22:49:46 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b0016cf3f124e1sm492646plh.234.2022.09.08.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:49:46 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net v4 0/3] net: mptcp: fix unreleased socket in accept queue
Date: Fri,  9 Sep 2022 13:49:29 +0800
Message-Id: <20220909054932.246221-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

The mptcp socket and its subflow sockets in accept queue can't be
released after the process exit.

While the release of a mptcp socket in listening state, the
corresponding tcp socket will be released too. Meanwhile, the tcp
socket in the unaccept queue will be released too. However, only init
subflow is in the unaccept queue, and the joined subflow is not in the
unaccept queue, which makes the joined subflow won't be released, and
therefore the corresponding unaccepted mptcp socket will not be released
to.

In the 1th patch, we factor-out __mptcp_close() which should run under
socket lock.

In the 2th patch, we move mptcp_cancel_work() to protocol.h and make it
as an inline, as we need to use it in subflow.c.

And in the 3th patch, we fix the problem we mentioned above by closing
all of the unaccepted mptcp socket in mptcp_subflow_queue_clean()
with __mptcp_close().

Changes since v3:
- factor out __mptcp_close() and replace mptcp_close() with it in
  mptcp_subflow_queue_clean()

Menglong Dong (3):
  net: mptcp: factor out __mptcp_close() without socket lock
  net: mptcp: move mptcp_cancel_work() to protocol.h
  net: mptcp: fix unreleased socket in accept queue

 net/mptcp/protocol.c | 27 ++++++++++++++-------------
 net/mptcp/protocol.h |  9 +++++++++
 net/mptcp/subflow.c  | 37 +++++++++++--------------------------
 3 files changed, 34 insertions(+), 39 deletions(-)

-- 
2.37.2

