Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EB7473
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:47 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id d10so4480297eje.10
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5RRJ/0oYCtVH/7XTSuDjrz7LlY/K2eG+ZlDL8+A70A=;
        b=H99hfXBv31PVmGo719drvsLuu/0VTMvp9S5VmiMbXE5uH2Ek8I8f4PbuA+fb/13Ulh
         ZrAMu9jmIhrrf6/2GJqiHHaIYoa5RYqSdP2I0vH5djZZ3+xckMxNlfDciakBabaRlqP4
         UHgmtam57GujfQ+wJqYXaNxAfmQIerd0ChXJKkI6K8ABqwcmn9BC/SrcyILxn0E4bi0w
         QjIJ/12E/laaAeHJKpB4dOolRkriSysr9mP4Ub6X5xf9Kzal8vWRBevEsBPkzWudfy+x
         J4NrlzSmWm/iI8QrH0+T+EeAEyW+HIV/JO9tmpgCkfGstGtxKxR/Q042Nb3ATwmxHYyl
         ApTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5RRJ/0oYCtVH/7XTSuDjrz7LlY/K2eG+ZlDL8+A70A=;
        b=03eBlrgxeBzXxJJ91PH1Z+JI/iiv7LRnehHEAsPYke3ADO7ysJ5DyUEcg75CO79cK4
         wmRsd8/JIoya+OLFkyUtGslbvR7G9cVl+SDvW1DzvgoafIbjLk6g5X3HMaKe2NCY5ugS
         2/56PiHxW2+6/reMXl17/vQVFD2kiKSO3NbuAabwje5LcXu/mr/Pk8cR+DnFleGDh0sy
         kA69OD1DQcyr7JKQGvr0/BWtjJ1BCblKHkov5z6eTYj5nDlaqIFMMLRana7bIYBe2gJ7
         wSpy4sTTwrfCEmuH8xGLR0OY1GXqpM5ez1RPdl4qZA8VDxv5IRpvuQk7158Dgd7beacT
         jNvw==
X-Gm-Message-State: AOAM533gDYnWsthjTAybGVX+EeaPn7QOIUZB3BtHAgMPS8OUnWxPssa8
	u3qDrNk+bykbz5clSKZhZZLbRJpwjSdeAjSiEew=
X-Google-Smtp-Source: ABdhPJz7zXS/WvcpY/tBLCqxRQaqI9ML5Z537YHhSIIkim4yszetcZPtlv40E+IpgE/a7lZkImD5xQ==
X-Received: by 2002:a17:906:c299:b0:6b6:baa1:e5cb with SMTP id r25-20020a170906c29900b006b6baa1e5cbmr2379266ejz.624.1645711005204;
        Thu, 24 Feb 2022 05:56:45 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:44 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 00/12] Refactor mptcp_join.sh
Date: Thu, 24 Feb 2022 14:56:07 +0100
Message-Id: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is very similar to the v2 but rebased and with 3 new patches.

The new patches:

- patch 1/12: 'ip mptcp' wrappers were missing in a patch which is in
  the export branch for a bit of time now. While at it, a new helper has
  been added to avoid long 'ip netns exec' commands as suggested by
  Paolo.

- patch 3/12: just to move an helper with the other ones

- patch 12/12: add new helpers to avoid long 'ip netns exec' commands,
  also suggested by Paolo.

The rest is less interesting. There are some modification in patches
6-8/12 because there are new tests in our tree: it was needed to modify
more code around the new usage of 'reset' and 'ret=1' but nothing
complex there.

In patch 6/12, I removed a new long comment that is probably not needed:
with the indentation, it looked even harder to read. If we need the
comment, probably best to create a dedicated function, use variables
with a clear name or use words instead of just a series of numbers.

Also in patch 13/14, there was a new shellcheck issue ("Useless cat.":
@Paolo: did you introduce this ShellCheck rule???).

Matthieu Baerts (12):
  Squash to "selftests: mptcp: Add tests for userspace PM type"
  Squash to "selftests: mptcp: join: allow running -cCi"
  Squash to "selftests: mptcp: add implicit endpoint test case"
  selftests: mptcp: join: define tests groups once
  selftests: mptcp: join: reset failing links
  selftests: mptcp: join: option to execute specific tests
  selftests: mptcp: join: alt. to exec specific tests
  selftests: mptcp: join: list failure at the end
  selftests: mptcp: join: clarify local/global vars
  selftests: mptcp: join: avoid backquotes
  selftests: mptcp: join: make it shellcheck compliant
  selftests: mptcp: join: helper to filter TCP

 .../testing/selftests/net/mptcp/mptcp_join.sh | 2435 +++++++++--------
 1 file changed, 1297 insertions(+), 1138 deletions(-)

-- 
2.34.1

