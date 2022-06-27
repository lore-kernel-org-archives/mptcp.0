Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84802586
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 10:06:18 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id k7so5660422ils.8
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=8m3WB+//ysQ/QTzRczGDgLf0MROTv+viJlKYiFMUEcs=;
        b=FbfLIZMVxAiPI6vvW+949ySv0/V2aF7cJ61i3WmkRDWtymSEmY9ThGZOiCQYspOOZP
         frMzWUNPl9dQ3Ys40EecRdtB2tb62H+zmnS1U/FMInwDdUY73rOxOSn27tZOF4mOsKv0
         teABoTieC+PrZgZSEJfqGMMn3meilLvoscV4rrt4jBD9YFMUx6eZ0b5px+GphnK+JKdu
         wKnM+1j+ze6CRGnppv0zaYCMWxyG0mk1kN2LCNkJnWsd9NY2i04rTiLelhWg9U+SDsa/
         PjU2/kAQO5rnEKwkartbNiqDo3W8U9AYh7V/225EbY6tjLPhB94s9jWbxO//DF6DRwgJ
         sVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=8m3WB+//ysQ/QTzRczGDgLf0MROTv+viJlKYiFMUEcs=;
        b=HwbVbvs2SNm8kBAqQLnX/XtrF6PK0fUe3rgHWFc7Dx7eJSX2BYC9my5G35LGGvh3Hl
         w5/ol/vk0mlGnXtHN5sqN2JtLHWmofc6V6Kf2qWDTtqKInG1becEaqfr06bTExvDBoCt
         8OUCfCRk57nFv3YzKQxRxhuzId1q3mT9D95s/UULyoegamdZ6gKTP4nc49UbYxyVsVoj
         6Dz4qCfyaR19jKMso5T+O9GtF1QUo9pWcNALV+4aAyStSWXOqCwZLWzlDGYqU/EaVxkj
         nzpyy+5tK19vYTjKv1Iug9A+KMot0mkIRmwlsfVx3sn/hHqe5F3heATe6zHou43BFFf1
         dy0w==
X-Gm-Message-State: AJIora/vKs3rPeHIEjoCXgRHJ9b9qrmar6jgwWC9bu57xGpP03wTtB8O
	6NBeqx27Px2pT4/CsbOkmA==
X-Google-Smtp-Source: AGRyM1vqDMs6/vPUEX/21A3MOLS3yr3ZCdYluW/K8UdKp0pu9hcbt53pIRCYPkMKMhYUvhFSqAWT6Q==
X-Received: by 2002:a92:cd87:0:b0:2d3:ce9a:f9a5 with SMTP id r7-20020a92cd87000000b002d3ce9af9a5mr6851927ilb.76.1656324377941;
        Mon, 27 Jun 2022 03:06:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.250.95])
        by smtp.gmail.com with ESMTPSA id l5-20020a02cce5000000b003314d7b59b0sm4617285jaq.88.2022.06.27.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 03:06:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
References:
 <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
Subject: Re: mptcp: fix locking in mptcp_nl_cmd_sf_destroy(): Build Failure
Message-ID: <af5e75a6-e0ab-b7f8-f3c0-7444a81896ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jun 2022 10:06:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/2568360433

Status:=20
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/31a3bb3c20=
ba

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
