Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0301748D
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:46:37 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id s5so1969623edc.12
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RQkBHkqVVlNBdfYlBPez6Aa/xafFXsCHxP/PM8mBXU=;
        b=iMEp/+8VhPQoT2hhYKGAkWkxgYVRxXnJaPM0pdI7WDCKwUYNSoA+zBHVfXF85XBfDv
         mTgv8Vu46fd0gTJQNxHB07X2Lv0dC8GpJ+1eee+ybk2J/0MILCoV+xGOyN2N+asTczyN
         BMUeIYpHTTfnnT3PPmL+x593iyLOAIuIJghurJIxRmVbTqCLmpB14Mvb4A7LqXdwpvt6
         ew9GTbD4ukomWWzVZKJJc7cpskwctUmVMw7Bjec4y9p8h6ICdd02DnVRh0fLMtdYd604
         IXIbBo9dCCGoPDFO44qQhWky4b6g8DHkA0JY6jrsdNRbRzM/aT33dmCgDmXct563yi2N
         qsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RQkBHkqVVlNBdfYlBPez6Aa/xafFXsCHxP/PM8mBXU=;
        b=qiwNKzVts079Sf0GjqigBy4CnJKr9ewAJrU1QjP5RCQ3Dk1Oo5vbZrpTY6/w2MTV32
         udvhlI7GiSNdN0D/4dVFocKuhkisvFrJ8AcjdFb4AldFFI+KuvoKNTh1mXxojF9c3gff
         1F9VFEVvXTy5lvPpEZju3WZqI9cHa+8JMZL7cDHMH+3U2CgVC3W+hsiVfxTPiEAAS9PR
         aTujBgZAGEwR19HIcfCzPHhR8K+qFRoiU0caiG+l6jlhfrnSsTwmxbDRoL5oLHYf/jnn
         QwRpgEgil+00VsZV1+WIytmKPcCFjNz/Ix2AfRqyXWSFDHsCSHlgmeyen18xAngm9yox
         oPsg==
X-Gm-Message-State: ANoB5pn2VtlprEFXinePGtNsHt6VlDMnX9uDn1Q+GBn88cg+etZc82Sl
	OELxNZjUJfs5s46mWFIQX9xgH0vTIiHPNg==
X-Google-Smtp-Source: AA0mqf6SSnbhl8Ee0+te5h7FMr+uu37JAmmCpslnEIWxnNwPKpafzbUvARXtQD10poW+TV8DDVPkwA==
X-Received: by 2002:a05:6402:12c9:b0:467:e9a5:77c5 with SMTP id k9-20020a05640212c900b00467e9a577c5mr3655472edx.289.1668444395812;
        Mon, 14 Nov 2022 08:46:35 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00773f3ccd989sm4377877ejb.68.2022.11.14.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:46:35 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix checkpatch splats
Date: Mon, 14 Nov 2022 17:45:56 +0100
Message-Id: <20221114164601.861295-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=smQjPAH+/QbNvN1uExkPqNBrWPOHB4r6Zs1lhHahdok=;
 b=owEBbAKT/ZANAwAIAfa3gk9CaaBzAcsmYgBjcnAw3dQyZF/3yIVoUUSLxg96A6MDVg/HFiiz8QLE
 8yw6QhmJAjIEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY3JwMAAKCRD2t4JPQmmgc1Q5D/
 dv02z8lgP88YtOH0PdudKkX9ZogpsbHNNknPkeZfvvrwMWTk3TNBPveaDEvBW6trtfDM3j58DzRKcf
 bXb3vZZ3zOhYU+uOZzRIR4jgMkrQSq0mmTGhy56z4XClNELEGPgzzKgR3gvHeTyCXEk3ZXWaYB4gb6
 +Kso4TaHGQ/X3zcnV8+h4VTdl8f/v+GarRMyKMriranzYXBAviKrRms0LQnOEh6hECp/avvoEHAxP9
 Wgof7Vv3CAWJrKFnbTzW3x17oG4eC3BJklcHlV2A+V03vzakMU+Zye9icRJNOKD7f/IWu5FTxBzNw6
 qcJ5ncTDYYQFG8O1dnFuBAFzTyligaPtmO78Z9Hq4vYHmJkwRuEgjKFDWKksq7XdrYcuNE1m14MRnM
 QbNH+0dvIshihTA5pTp08VGPh+UVd0QZmTniLcYNmXTvHFrRct5bO2zWOAItk05CgzeDa/o9NB361A
 q8xQAIM/BzYB38T/0PMyv0ad0m9RvDQ8Ba7xK6USVfwdiOP5sjUrKzdtYdojfVidvecJzNVT1RSx/v
 eIAfk398FW5n02RVbt4rGxkYK6sKfbnkcSdlGISzIjk3JiP9VU2QwlN4QFzyiEUKznP3HULjQWJ3VS
 HkYDY/BDitlQ5PX3a1JJb1/kZsiM+5itV3Pr20AWpNX0aTs/In61KyqHRF
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Just some small quick fixes about "issues" I saw when I applied the patches last
week. Nothing important: function names, place in the .h and small checkpatch
splats.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Dmytro Shytyi <dmytro@shytyi.net>

Matthieu Baerts (5):
  Squash-to: "mptcp: implement delayed seq generation for passive
    fastopen"
  Squash-to (part 1): "mptcp: add subflow_v(4,6)_send_synack()"
  Squash-to (part 2): "mptcp: add subflow_v(4,6)_send_synack()"
  Squash-to (part 3): "mptcp: add subflow_v(4,6)_send_synack()"
  Squash-to: "selftests: mptcp: mptfo Initiator/Listener"

 net/mptcp/fastopen.c                              | 8 ++++----
 net/mptcp/protocol.h                              | 8 ++++----
 net/mptcp/subflow.c                               | 6 +++---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 1 -
 4 files changed, 11 insertions(+), 12 deletions(-)


base-commit: ff1606d98e1c56fd9f181210e5463528173e99c5
-- 
2.37.2

