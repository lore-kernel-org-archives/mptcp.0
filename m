Content-Type: multipart/mixed; boundary="===============0779553528792926111=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC net] mptcp: fallback in case of simultaneous connect
Date: Wed, 10 Jun 2020 11:59:12 +0200
Message-ID: <086c2cb689bdadbceb25e9b5a78937460eb934ef.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2006091454110.26344@hlin4-mobl2.gar.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4631

--===============0779553528792926111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-09 at 15:00 -0700, Mat Martineau wrote:
> Does it also make sense to set subflow->conn_finished to match more =

> closely what happens in subflow_finish_connect()? Looks like this would =

> mainly affect the MPTCP_SUBFLOW_FLAG_CONNECTED that gets reported to =

> userspace in diag.c

yes, it makes sense: I will respin a v2 with:

- this addition
- the typo fixed in the commit message
- the subject prefix targeting the correct branch: since it depends on the
fallback rework, it should target net-next, not net (and I would have
difficulties in detecting a proper 'Fixes:' tag),

thanks for looking at this!
-- =

davide

--===============0779553528792926111==--
