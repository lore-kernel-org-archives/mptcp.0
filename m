Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45102C99
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 23:52:49 +0000 (UTC)
Received: from smtpclient.apple ([86.159.109.142]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MjSwu-1mBgIc1oWg-00ky6U for <mptcp@lists.linux.dev>; Wed, 01 Dec 2021
 00:47:36 +0100
From: Phil Greenland <phil@quantulum.co.uk>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Marking initial connection as a backup subflow
Message-Id: <7028B7EA-64DF-42C8-8065-24C879A71231@quantulum.co.uk>
Date: Tue, 30 Nov 2021 23:47:35 +0000
To: mptcp@lists.linux.dev
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Provags-ID: V03:K1:xia40LIjkBQD6uvvOTd8gfn00IKI0GD0nF492/csjMeWPmVvh41
 UKI2SQLixN89CTXoJH7ED5r7qd4Qg/FLpWqnUDAO9h+cWg2E50BH2jEE4GRVQfG7Vtfs9bO
 TNPNhVpW2sYWM3WG6NI25ThGsiXX5U5AxCEd5ddZJYcdFE8MhHTX10cqUiBL2UcLcTOnZP1
 chpgdXZjS1dUxTT5fxiEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LBtIHP6W4Hs=:HXkr3xfTFVDT47qEmgMK+h
 NHcLeL0tAO2e0gDOfPYbQe6GgXFkO2hi7b7nBmcSOhQiDkgTVymHW1kqtn3eRdbo8dzc6mQh/
 uw0kvwVaZN3d1FgcDobQ4KTKBynDRrbHvnaeZOZSeP9cb9XwWFkQJbEL6IF/47hBwmtWFVX8p
 L5J6MsbCLHJIkjwZ0+/dW55I34Ah/L1giECIQc8y5Wte0Pw3un2OhTTZHo0LiM++MxLmL5mzK
 cxyV98nBGVx3yjz9pHoxsj7ZX5maM8g/xurTaDnGZnxOuPi7gMAaI2TF4UT3FboZZPgpUt+SZ
 RjVlkpfoTh483BVPS0kBQlFRDASZicBDocbAJYuhRfTgA+oO5ao8UQSKqAxMZW0hYMzXjAYEk
 uZuzfikCBLNuUBBIO6+z7pqGxzMdQ14b3Hdmgw93igFzPEfojB6pdvdXPSynJAgJAKmypFbvz
 NKftk5HtN4d7JvBkQCfhNgbe5sX8M2n6r2G3OudB6T245qYy2154kj3zDZZ0MaATNW8fSXbf0
 UW7Xcq3mck80W8dF6y9khB3BPjMczCXqeJr8IW5kgsBvh7aOihhBVpn3c5CaafphfnCTvIEoM
 6EHx5CPz0FNiIGCa+TPMuk85Jz+E4huIfW3CiAhV8b8JrYlbhEWKJaeVfwnDs1dAgX7X2kwnm
 aRr32dBVGWIj1MinzWqzKsvAb3V17oFPlG7wIYohJLyxCrb8fkcHHByXijmG6pvrLSjU=

Hi,

I=E2=80=99ve just started looking into marking endpoints as backup =
subflows.

I may have found a slightly odd corner case I could do with some advice =
on.

I=E2=80=99ve got a three links, two of which aren=E2=80=99t always =
available but should be preferred when they are available. One is almost =
always available but should be treated as a backup.

I=E2=80=99ve therefore added endpoints for each of them, with the last =
one also having the backup flag set.

My main routing table is configured to use the backup link as the =
system=E2=80=99s default route (given its availability is higher than =
the others).

When all three links are available and subflows established, more often =
than not the backup subflow is used in preference to the others.

Looking at the subflow selection logic, the non-backups should be =
preferred over a backup if available.

Given that my initial subflow is connected over the backup link, will it =
inherit the backup flag from the endpoint configuration?

Would appreciate any advice you can give me.

Regards,

Phil=
