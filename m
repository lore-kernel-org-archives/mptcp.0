Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA829CA
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 19:17:35 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id q14so93734011edi.3
        for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 11:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAUEiS8XM+HXBu8v+HD0pYSMBJMujPpw52D4jF1QpE8=;
        b=4GFJSVYQWDKgYiJxJIqvwhgfC5uuSO62kMiPsZFX5zKeOrWET2xGOp95LQpXNWqgrV
         Nac0ikFUDqwRkYm3mmdGwC54qR5C9swSklVdcVY/oDx6VWTCAC+rEjyog9UHJpC36bMN
         OHsuru8XwUz7VzwW0BBsHF59fk8sp1brhExq+4WB7uOyw2Z+xvGKJdwjBlESswpMWBD+
         k1X6f6zVPoD+IP69QC5eWlMwqkZQd6VwjFl6ZtVoxxOhIJ0JB+ObLq8wN2IUorC5hpZT
         OqqOaNPoG8ijxIWopKrR6r1Df3RkbzCxkvExunaC0uRhS5GOi6q0C/8M38SNumb0PcH1
         rCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAUEiS8XM+HXBu8v+HD0pYSMBJMujPpw52D4jF1QpE8=;
        b=s8oAzkJ6GXgqInjgPJncHuqgL8ZzrQ2lYQJeJxLir4PKdjynEdgr2GLF7jG5qGmpco
         oOjBVf8TyJhItCV/Ia+gwyKAWC7dDcMAX3wvenCjjyUcXFqzmm0CHdd6Clq5QXfPGZbu
         VFm1bSVu0jpvCpu6ycDb2bS9QFMqmJ7tcS2VURYhlb/H75x8m4bTOS9Q7KFMi8uzpcTz
         lPpdavAHeja3yKJ6qSuYa7JP39o1uah+JEHeq5vKcl/cUMC4JTRWB4FwHW4Kghf646bS
         yuwReNlAq7gvJcZ3WAfUXc1eDcaQ50HEXKgxqPas4n+IY5Zppq1/3kTFcknfIwyNSkFN
         hEbg==
X-Gm-Message-State: AOAM532ChCJsNwLqadKrJ8mrklLGXjuharwYXnUb0PEMydbHL2S4sUg8
	RjDi7XOhdowsC5XKFgtrgOpUtL+xUqIYylYx
X-Google-Smtp-Source: ABdhPJwGPer2lSzoXrPDMWRrFMbm+LhaMay23dov0kxnn0B78Ll+Xj0Eg6gZthkAamG+7H+ZebRXmA==
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr30934314edd.158.1640891853967;
        Thu, 30 Dec 2021 11:17:33 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id m6sm9918244edc.36.2021.12.30.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:17:33 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 0/4] Clarify when options can be used
Date: Thu, 30 Dec 2021 20:16:47 +0100
Message-Id: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of Geliang's series called "send MP_FAIL with MP_RST and
others".

The Squash-to patch is the same as the draft I previously sent but fixing a
compilation issue: MP_RST can be sent with MP_FASTCLOSE and MP_FAIL but
MP_FASTCLOSE cannot be sent with MP_FAIL.

Patch 2/4 has not been modified.

Here, you might want to start looking at "mptcp: clarify when options can be
used" and check if everything is OK for you related to when options can be used
together.

If this is OK, the logic behind the Squash-to patch should be OK. Of course, the
implementation might not be OK but that's different :)

Patch 4/4 is there just to have mptcp_established_options() in sync with
mptcp_write_options() (and the RFC).

Happy New Year!

Geliang Tang (2):
  Squash to "mptcp: implement fastclose xmit path"
  mptcp: print out reset infos of MP_RST

Matthieu Baerts (2):
  mptcp: clarify when options can be used
  mptcp: allow sending both ADD_ADDR and RM_ADDR

 net/mptcp/options.c | 94 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 27 deletions(-)

-- 
2.33.1

