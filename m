Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130CC4C96
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 23:23:46 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id q9so10711095pgq.8
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=y5PPKemxKoESz8LPE7yr8JCQc1ajpCYy85Quylcy9gQ=;
        b=N7iT5oFY4SA7qqRvsgtz06QKAhx54ysvjel+W1I4Rn5wDqh0+7ufPUQLyXYFHoqhpg
         Ne4NDmaoefLWkplJdHTe4viKk65EZYvr/CRjHesfflm5BEwZiXgfXRLDYhYcfIJMqSL3
         9gIqPlAo/jFjrjB6UiolnsyMEZzW+IE5NSlmy+eHuhUtFlCj0rZSbCx7qWfgMrvVQup3
         K3J42Vb7t2oCHFqGEbK5wWOFJjIC27Qkj2qXqo+BJzErAmoUMv4uWHPrdoJWYlGvJEiD
         WC0j+ybapPloS5g/sHkZPKSB/rQmrjGnPOwLtEYurVazl7JbZaRCjfZ1LGWcmFlKkwcY
         ZI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=y5PPKemxKoESz8LPE7yr8JCQc1ajpCYy85Quylcy9gQ=;
        b=LUVLF6k8NFHi6dV4Ka6qkAOyBPVr36z9P5jg3DBt60jvjhuT5lJeeW0ASwDVHF7SZi
         D85z6nGWd+0RDUg0waiCmgdA/3jnAtvPvvcP6CutGfLZUCd4HPpZ7ol5SJW33zq6cpVj
         nrYh3CpMF3eA+X0tJCLypGQ8gQU6Eo4uI15vob8lwv8aPK0mMeug/gEBpByWfsIbogbc
         h04TQQfKSEtdjaivjj8hZabincasiuFYvY6RyrbIURmg0iQXJaw2vch+YvdDnvDkeagO
         lyE5dDCa2rqz/rQjRsoEQd485VRjI3Aj6Sy5A/Qqi9aWr0QDHbYi4jORpBzoDBPmOkmB
         2hdw==
X-Gm-Message-State: ACrzQf1rKQYBZ3u5v9Ls9MBatRtKDoaqA5J/1d8x21ErsYjSifzJdumn
	gRjYfoCl219IqnGya6L++DsPobrwaOR1
X-Google-Smtp-Source: AMsMyM7fU8FmLST38cvG+WvOBXCa/2oEAspZTJh0BaNsL0g/Y/mMs7BUhAbj8KX4xpwEkuBxta3t1g==
X-Received: by 2002:a05:6a00:1d9b:b0:541:1894:d5db with SMTP id z27-20020a056a001d9b00b005411894d5dbmr31555444pfw.78.1664321026408;
        Tue, 27 Sep 2022 16:23:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.70.254])
        by smtp.gmail.com with ESMTPSA id 22-20020a621416000000b0053e93aa8fb9sm2303140pfu.71.2022.09.27.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:23:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220927225341.14165-8-dmytro@shytyi.net>
References: <20220927225341.14165-8-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Build Failure
Message-ID: <09e33d80-b5fc-5555-2950-0d46908150f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Sep 2022 23:23:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220927225341.14165-8-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3139594634

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4285eae5e20b

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
