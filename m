Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9F477E39
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328037; cv=none; b=UBu52R852DQVuzkkld8iOQIZmX0/YVOykE/zXjlt2lHUFzSQiC41D9qtMUfJ1j94eoeZ/E78/siZinuBWiO1oM67Nj5rp+BLayVUkfTxpsyimzv+5Gh1UtbzJongQfqmGBpAjXIWpFjzEgwyqZ0GCve6c6dY4LkpkYXl2NzAhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328037; c=relaxed/simple;
	bh=77P+tsKV1AnnXWjHbwKxc7/J5NkZfQHxKfE8ZWc6avo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qvF+GxjhSPewGV3MmiVY34iTKRxWXtmXjlcdrDFORvS1lenIBJ8f96ZfcjkLIFgLLvj4vIHLwuiTb/f8EEu3ksqAa95HCK0l5H8r2uVXw0h8R1m5QDJnLdHoQkAfhE0sfl8rp6zCc7fY0xgd4tutAtqC1RdEfrdPymQNdOCT8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5H7pfTe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5H7pfTe"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848643382fcso1001535b3a.1
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785328031; x=1785932831; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+H4vDFS0XDZEMs0GZW9PrsZb/TqXyOgIbmnEdKrqqHU=;
        b=b5H7pfTeRVI8/0RPl9vBoheqG2MaPTE66hSWYp432kOfyNVdOJAZfnRkfv6BifHN7w
         uuj5yOr8o5nRaWk9LTj5g8neU4IafX7FU18wDFjXb1NUbpX/tadUehFWDDfJTSbjDUXp
         d8oV/bN0rHPaetFHNB9gskrwPxRWrN8OFXfxtz3HQj+QWGBBhr+EkvFHjuxNo7R+NdIr
         8zH1ccgHLiXfF9fuRn1RkQ694CNiFFiXu2mpYmwD7MKlm9/pF53xgAYQOb3vMKMkPjLa
         8s3+w1z5/oOZVCHKPV4pGicfTtEyECkB54ym3uHL60MP5SQB/zX73okR2tbYVSfrcoiW
         kb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328031; x=1785932831;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+H4vDFS0XDZEMs0GZW9PrsZb/TqXyOgIbmnEdKrqqHU=;
        b=fEdaM9PVrx4E6NFgBNzc22MolmpTIgzs2kyX8f2jkykcAbgpLJtz6e9qzbTDjW4jxG
         Up5nDbIC25zbggaGPeGgxUD0jsI+2YKE8paMmx0yy8Klgj7/GEMpYCSuubqhLSWGWnH9
         sa6nWgE3HCw6FwObinNgfoXlHcBK5ir0rGEEGruBR5JZmWpURoDoUUkZBHGAKg/LSUFs
         YmimU8lCFCTwPdlJa9TXsfFsDx9tJRzciZjyQJPODhhEKrFOTWOGHPyfX01UxuQv7J4w
         Z1jWmKYyXuth8EzVL6hy/74WeJ3t/OxKyWoSLsUy5l1lF+V/CsLQqxSSHS7Alg83mC0t
         mqZQ==
X-Gm-Message-State: AOJu0YwiWHxZx8J0Fcqe3/KGc4Ag4HnBxppXExfpqrRPI0xlv4zbLVvk
	BwjW+zqr/Ku4dFCAdmfCj1fELi+BRbPCADYTnBTQ3gFYQ41ntYGtZBk=
X-Gm-Gg: AR+sD13zAUhzskiHDPukYH7sTON7Svu3/AocA9PuzOY7usKOkwco5KpqOhE2fX1RuEw
	MmnWGpln+JSXBZHGmQZ5hLel0+FUZAYEHuOla8Q+KCdufbpqnye1Y/f4daYuBMtrfSobCz3N5uy
	lj0DHpJte2to8/BO7dO+NYlsTqVUF1UAPCnoG8edVEx0tpHrrTJhImlpeZqK8cZS4EI6MM1ZRtm
	MUJfkfCSeijVgQWUS+Yos6XugPuE+5bV0ueVuCAJ4dKPZUycWgGVo268dAMYS1i9x+MreSdfXoq
	fuLE5RdoWKSt8Rv8P24SRMFtvZFrDd8j8+qsYzlY1qzY3UJi2iMddkmmWgfl8G2XIIa8xkbjq9S
	dNSML5uHPZJUw2l3whJPlENR2rM0IIp+HZhrkvbXYg0xRnO4RGsTd7lRQPpS0F0ZsFT+03c7Wla
	c0jYEOjrh7vxQ4aZfabZ2ZEb41nto121ZxGsmVjasc8oIUtIJg9q8W+rayTGRqe6DlvwUXyNSZW
	jM=
X-Received: by 2002:a05:6a00:188b:b0:847:99b4:d011 with SMTP id d2e1a72fcca58-84e9331bbd5mr6489766b3a.39.1785328030658;
        Wed, 29 Jul 2026 05:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.245.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm1295311b3a.22.2026.07.29.05.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:27:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785307984.git.zihanx@nebusec.ai>
References: <cover.1785307984.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in
 diag dump paths
Message-ID: <ed29bba6-5176-92e5-74b6-b7ba249a8332@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:27:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Zihan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/304486=
62026

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b7b5896ea9a5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1136597


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
