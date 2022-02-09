Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3232F43
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:47 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id f17so6262241wrx.1
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HB3G78abj6oWpP9cmISagEQd3f3VU5DpfVaUd/6wcCU=;
        b=IfcRVbf9bi/WwhKJFqmrqiKSpNNHQ/InMRDY+uo1ZsijdqRp/EVcdAVNLFogHKhrR+
         9QuTH9GB56kCNqIWOSHHoQfpk6N+sSDvYdYBy+naZUu04izch+EDgfYyZbchL7qptvUr
         b7CGHY/1pH84LDXjKm+X2ejY73ZGfnD7RqCVQXX3P02HzrdXDxr1eRd8174bckANW3WU
         jNRGJPq8RrxmYAkZHSoElHWcVhNjXgo2eLR6lGyTq+leSwFZHK3YY9x5CkZTN1AwG74U
         GMBg2v0e0j5ShffVH4hqQuOgmmz/792VHbT3VWptu/p/RL9RmSNgKdo3DQQbZ/MLk/bd
         DpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HB3G78abj6oWpP9cmISagEQd3f3VU5DpfVaUd/6wcCU=;
        b=ZzOEKxh+qP9NPSdUNY9O9uOej5U8wC1bTu/SmbNAvq2Sgvw+FQok6aiDlpOJQLD1oL
         EBHDMFkcADQ+82GUW1Rkbm/GvvPTESYAR6DbNRO/Q5sRhu/nf1BqzlEmIfjIh3/kVyuc
         ObDzyFRq/zBOUgeOxgIWtlq9zZyfqcJ5Ky5I3Syekeq3robcJgplGqzOWBzGHENdT/IP
         69zF3UnJISfEXoXuBxPILUpK4RqVjdX6QG0KOU7GEctocutKz0uJYuxfHtsmnXh0Rv/x
         3TNTxuKRm+EGQQg3unxPW2/ccJgUWxM2+SMTZYoR6v/n2DC06h6uas+ACl9zUG8eu6CG
         LO5A==
X-Gm-Message-State: AOAM533WHZhSGHxfZvZBHEd7QlzWsM9X9OOB90Ga0Wd5Q04oFaOJRxZZ
	R7N0PHgQgYUq4WaltZWKZhETiGCDr+MIGDZg
X-Google-Smtp-Source: ABdhPJxqpm30faFtYwYMezDlcTtIS5sPqwVHdtridAkl/J5HPaYtpJUTM4EYjVra6kj8zQL6paMUqg==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr3844729wri.337.1644441945571;
        Wed, 09 Feb 2022 13:25:45 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:45 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/9] Refactor mptcp_join.sh
Date: Wed,  9 Feb 2022 22:25:11 +0100
Message-Id: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I started this series to be able to launch a specific test without
having to modify the script to comment tests from the subgroup I didn't
want to validate when trying to reproduce a specific issue in a loop.
That's what we can find in patch 3/9.

While at it, I:
- fixed one issue with the options (patch 1/9)
- stop if an option doesn't exist (patch 2/9)
- removed unused vars (patch 4/9)
- delay some actions to the first test not to do them if no test is
  launched (patches 5-6/9)

But after having seen all modified lines, why stopping there? So I:
- clarify local vs global variables to avoid Bash's classical pitfall
  (patch 7/9)
- fixed all issues reported by ShellCheck except one (patch 8-9/9)

These last 3 patches (+ patch 3/9) will create a lot of conflicts. If
we are OK with them, probably best not to wait to long before applying
them to avoid big rebases.

For the patches that are already in review, I can fix the conflicts when
applying them.

Matthieu Baerts (9):
  selftests: mptcp: join: allow running -cCi
  selftests: mptcp: join: exit after printing usage
  selftests: mptcp: join: option to execute specific tests
  selftests: mptcp: join: remove unused vars
  selftests: mptcp: join: create tmp files only if needed
  selftests: mptcp: join: check for tools only if needed
  selftests: mptcp: join: clarify local/global vars
  selftests: mptcp: join: avoid backquotes
  selftests: mptcp: join: make it shellcheck compliant

 .../testing/selftests/net/mptcp/mptcp_join.sh | 2342 +++++++++--------
 1 file changed, 1257 insertions(+), 1085 deletions(-)

-- 
2.34.1

