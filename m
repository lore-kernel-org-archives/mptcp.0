Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147128F3
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 06:29:17 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b021cddb74so522215ad.0
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686205757; x=1688797757;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCBNY6qBbkyVLAb41TVOW1ILKL2CLX1RVAQQxdFcitc=;
        b=Ng58vsB6rM7D0Y0wjZc/Lo01k8JEY4k4ts9onIiXO8rIiGB9YwpoJfOcyLBhM90jrs
         rCevRfK+n1DkL376GYPX2tFPJ2+m+SedXYMSyHNcoA4Ts6mJbxrIzYwx8lotcVufDVYx
         qlXYZZ8izbf5PCAZdAjim/Of3hkwMOXtIs5XnTGLNYlU9/7ChA9/1bQW8RMywVZdASRo
         e5xGLFHMcNF/of9NiYBlZ+g8iWkbXg5XddFMaVbLnny26VAfBxmJzjlrCKzNmzTCimWV
         qbewbqt7XTkn3rB8nRqPmdx+Me2xXZ2htT7x76U3ab9NTT2gif4v0O07bRSFVmsM+TIo
         0zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686205757; x=1688797757;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCBNY6qBbkyVLAb41TVOW1ILKL2CLX1RVAQQxdFcitc=;
        b=P5KZs6S24/G7jbcFscYk0SUjJQGK9EE3rdF+9ZA1CqgeUIPZ74J2z9/l53smNKzb/+
         4A1d2c6jR+8XqCYKHhDJ1vIp/yfrcIZoFzkfk4CrZzeGbaZIjxyXGKwlkdb4tUDrG33w
         /HsHcUy4UmJXMby2Dtufoyi0efCl6QU7XUUY3tDYENcPnaVcE0MzLa7kMC9eSQqU3gc/
         /XSKWVd9TOpzpoOjG9MXZ+ICJVeT4g4rNJDJraqmCgZ+jM29gZMXqoSjmRVvPX0bYCVU
         yZH7ThETQ5djMMCBq6oPzie6hevCslvFlj6felgYfaEChx23hUymxmujxy6Mn/+WRSJw
         KXrA==
X-Gm-Message-State: AC+VfDwFEnzU7FMSctCvaa5N4sXb9EL5s5JVCVvYgFBKQyT/M5eVysGj
	+X+9RnxLsfcaQrBScbi8fzhfzPRD3DOq
X-Google-Smtp-Source: ACHHUZ6j6yNMDeFy5sUuWEV/t8cXR+kGNIaSxTKKviWUP0axYoXqNq7vkimLupbCYi0leBF3QVjnew==
X-Received: by 2002:a17:902:e812:b0:1a9:8ba4:d0d3 with SMTP id u18-20020a170902e81200b001a98ba4d0d3mr4763322plg.8.1686205757259;
        Wed, 07 Jun 2023 23:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.14.138])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001ac4e316b51sm590527plb.109.2023.06.07.23.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:29:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
References:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Build Failure
Message-ID: <b0c73bee-1aec-8fbe-eb07-39141e09f142@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Jun 2023 06:29:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5207978758

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7c8401a578=
74

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
