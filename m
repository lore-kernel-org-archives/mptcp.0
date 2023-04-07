Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663D1FDB
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 09:58:43 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso42930559pjb.2
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680861523; x=1683453523;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF/8IwJVfMsXicfnW+filTHzGgzzWFHXoUCYxMjStWk=;
        b=RLMJors2E3JF04mP/8cG0ws37WYen1mehY4vADMpBK0xaHg6htIIv3mQEFHbahfO2q
         WBV80/ZoFMor6dRVlRO00Saz4bDMh8YtsV5xRCAvS8G4ms7TYUVD4t/GvbGfjtGnAx/U
         yN4UCTD1Ty3Oy7tito5E9G5hTKyN//PCPh2THNocnlhWBgIPKfUzWHxR0kQfioSD63AD
         h2lV01ezN8OoyH7MMgy6O/4/fa2RobM2/TQftvAm7TFr/MHy/fY4IzhywlPSKyCBHwxt
         Hv2XTIETR4UOqLNZQb48IRJo1PVSbVwEdShv/gM73rQiF8g3PoOj5PdP0hMWQNcYPBbJ
         tUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680861523; x=1683453523;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UF/8IwJVfMsXicfnW+filTHzGgzzWFHXoUCYxMjStWk=;
        b=4hVlND2XAF7yeMEYiAiiK6IgpBDb6UYGwFlRnyKhbo8YEHOq7jvaeDoeRdZa+m/vA1
         +Rmb1wjDC8TYQV4nHucWt4GcYmwFe/bnKk2fT07vVljRA71MklZo6pyt/DZQ/YjrR13P
         KY/QvwUyU7OjDTJ/EEfCp20XE/x/VPMpjTmtnoVfydcmbqZ/ZK3X952hd/pHsKtQ/FVj
         8/0Y0oZ4v4+ckfuZVBSZNeE50aVLHANrt+UNZ5s/WqC73UutL6/UYUWxrnLgxAUS1mZu
         IMWfUvRfb/fWWmPvbem79psKxGeGojDvpQQS1t8WI0arocESYyD4sQ1Odz0nJpafx6Ok
         mRLQ==
X-Gm-Message-State: AAQBX9dvNafcSRuvDzeUJk+LpeCk4qoPHSN4Ua068XUSIjJIj6ROEqpv
	i/vxE95nLcQu2HfJX5h2hQ==
X-Google-Smtp-Source: AKy350aICbabkmkRLZ7kw2O4NmSAkejky8pTBaj3JC+BO9Is2Ll70UrVDiGX+9Ut1nw5M0Hk7Ep2JA==
X-Received: by 2002:a05:6a20:b213:b0:d9:6650:ef14 with SMTP id eh19-20020a056a20b21300b000d96650ef14mr2491993pzb.31.1680861522795;
        Fri, 07 Apr 2023 02:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.73.36.85])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b005a8ba70315bsm2725452pfo.6.2023.04.07.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:58:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>
References: <20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3jvtoa88@z>
Subject: Re: net/mptcp: use netlink policy generated from YAML spec: Build
 Failure
Message-ID: <68fbf830-09bd-d4a1-6281-a5ded6d70f28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2023 09:58:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20230406173159.vjKk7zJ6cyrQl9c5RwemQMbWO6eJd8GHzW-3=
jvtoa88@z/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/4=
631535712

Status: cancelled
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7d20481ccf=
26

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
